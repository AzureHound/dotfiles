{
  lib,
  pkgs,
  self,
  self',
  config,
  ...
}:

let
  inherit (lib.modules) mkIf;
  inherit (lib.options) mkOption;
  inherit (lib.types) nullOr path;
  inherit (self.lib) mkServiceOption;

  cfg = config.pixel.services.home-assistant;
  hassDir = config.services.home-assistant.configDir;
  thread = cfg.radio != null;
in

{
  options.pixel.services.home-assistant =
    mkServiceOption "home-assistant" {
      port = 8123;
      host = "0.0.0.0";
      domain = "home.${config.networking.domain}";
    }
    // {
      radio = mkOption {
        type = nullOr path;
        default = null;
      };
    };

  config = mkIf cfg.enable {
    pixel.services.postgresql.enable = true;

    networking.firewall = {
      allowedTCPPorts = [ cfg.port ];
      allowedUDPPorts = [
        5353
        5540
      ];
      interfaces.wpan0.allowedUDPPortRanges = mkIf thread [
        {
          from = 32768;
          to = 60999;
        }
      ];
    };

    services = {
      home-assistant = {
        enable = true;

        extraComponents = [
          "default_config"
          "isal"

          # onboarding sets these up, and they fail without their deps
          "analytics"
          "google_translate"
          "met"
          "radio_browser"
          "shopping_list"

          # matter and thread for the ikea devices
          "matter"
          "otbr"
          "thread"

          # watching the server
          "systemmonitor"
          "wake_on_lan"
        ];

        extraPackages = ps: [ ps.psycopg2 ];

        config = {
          default_config = { };

          recorder.db_url = "postgresql://@/hash";

          http = {
            server_host = [ cfg.host ];
            server_port = cfg.port;
          };

          "automation ui" = "!include automations.yaml";
          "scene ui" = "!include scenes.yaml";
          "script ui" = "!include scripts.yaml";
        };
      };

      postgresql = {
        ensureDatabases = [ "hash" ];
        ensureUsers = lib.lists.singleton {
          name = "hash";
          ensureDBOwnership = true;
        };
      };

      matter-server = {
        enable = true;

        # one of the PAA root certs on the DCL is malformed, and cryptography 50 throws on it instead of warning. that kills the startup task
        # before the websocket ever binds, while systemd still says active top-level, not python3Packages: only it has the server extras
        package = pkgs.python-matter-server.overridePythonAttrs (oa: {
          patches = (oa.patches or [ ]) ++ [ ./matter-server-skip-invalid-paa.patch ];
        });
      };

      openthread-border-router = mkIf thread {
        enable = true;
        radio = {
          device = cfg.radio;
          # the MG24's thread firmware (SL-OPENTHREAD 2.4.4.0) talks 115200 & CTS is never raised so flow control would block every write
          baudRate = 115200;
          flowControl = false;
        };
      };
    };

    systemd = {
      services.matter-server.path = [ self'.legacyPackages.chip-ota-provider-app ];

      tmpfiles.rules = map (f: "f ${hassDir}/${f} 0644 hash hash") [
        "automations.yaml"
        "scenes.yaml"
        "scripts.yaml"
      ];
    };
  };
}
