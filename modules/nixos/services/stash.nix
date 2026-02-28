{
  lib,
  self,
  name,
  config,
  ...
}:

let
  inherit (lib.modules) mkIf mkForce;
  inherit (lib.options) mkOption mkEnableOption;
  inherit (lib) types;
  inherit (self.lib) mkSecret;

  cfg = config.pixel.services.stash;
in

{
  options.pixel.services.stash = {
    enable = mkEnableOption "stash";

    port = mkOption {
      type = types.port;
      default = 9999;
    };

    domain = mkOption {
      type = types.str;
      default = "spice.${config.networking.domain}";
    };

    mediaDir = mkOption {
      type = types.str;
      default = "/media/spice";
    };
  };

  config = mkIf cfg.enable {
    sops.secrets = {
      "stash-jwt" = mkSecret {
        file = "stash";
        key = "jwt";
        owner = "stash";
      };
      "stash-session" = mkSecret {
        file = "stash";
        key = "session";
        owner = "stash";
      };
    };

    users.users.stash.extraGroups = [ config.users.users.${name}.group ];

    systemd.tmpfiles.settings."stash" = {
      "${cfg.mediaDir}".d = {
        mode = "2775";
        user = name;
        group = config.users.users.${name}.group;
      };
    };

    services = {
      stash = {
        enable = true;

        username = "admin";
        passwordFile = "/dev/null";

        jwtSecretKeyFile = config.sops.secrets."stash-jwt".path;
        sessionStoreKeyFile = config.sops.secrets."stash-session".path;

        settings = {
          host = "127.0.0.1";
          inherit (cfg) port;
          stash = [
            {
              path = cfg.mediaDir;
            }
          ];

          notifications_enabled = false;
          theme_color = "#24273a";
        };
      };

      nginx.virtualHosts.${cfg.domain}.locations."/" = {
        proxyPass = "http://127.0.0.1:${toString cfg.port}";
        proxyWebsockets = true;
        extraConfig = ''
          client_max_body_size 0;
        '';
      };
    };

    systemd.services.stash.serviceConfig = {
      BindReadOnlyPaths = mkForce [ ];
      BindPaths = [ cfg.mediaDir ];
    };
  };
}
