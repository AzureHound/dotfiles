{
  lib,
  self,
  pkgs,
  self',
  config,
  ...
}:

let
  inherit (lib.modules) mkIf;
  inherit (self.lib) mkService;

  cfg = config.pixel.services.home-assistant;
  hassDir = config.services.home-assistant.configDir;
  thread = cfg.radio != null;
in

{
  imports = [
    (mkService "home-assistant" {
      port = 8123;
      host = "0.0.0.0";
      domain = "home.${config.networking.domain}";
      radio = null;
    })
  ];

  config = mkIf cfg.enable {
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

          # misc
          "pi_hole"
        ];

        extraPackages = ps: [ ps.psycopg2 ];

        customComponents = [
          (config.services.home-assistant.package.python3Packages.callPackage ./cudy-router.nix { })
        ];

        customLovelaceModules = [
          pkgs.home-assistant-custom-lovelace-modules.mushroom
          pkgs.home-assistant-custom-lovelace-modules.mini-graph-card
          self'.legacyPackages.mushroom-strategy
        ];

        config = {
          default_config = { };

          recorder.db_url = "postgresql://@/hash";

          http = {
            server_host = [ cfg.host ];
            server_port = cfg.port;
          };

          frontend.themes.mushroom_custom =
            let
              c = {
                rosewater = "#f4dbd6";
                pink = "#f5bde6";
                mauve = "#c6a0f6";
                red = "#ed8796";
                peach = "#f5a97f";
                yellow = "#eed49f";
                green = "#a6da95";
                teal = "#8bd5ca";
                sky = "#91d7e3";
                blue = "#8aadf4";
                lavender = "#b7bdf8";
                text = "#cad3f5";
                subtext0 = "#a5adcb";
                overlay0 = "#6e738d";
                surface0 = "#363a4f";
                surface1 = "#494d64";
                base = "#24273a";
                mantle = "#1e2030";
                crust = "#181926";
              };
            in

            {
              modes.dark = { };

              primary-color = c.pink;
              accent-color = c.pink;
              rgb-primary-color = "245, 189, 230";
              rgb-accent-color = "245, 189, 230";
              light-primary-color = c.rosewater;
              dark-primary-color = c.mauve;
              text-primary-color = c.crust;
              text-accent-color = c.crust;

              primary-text-color = c.text;
              secondary-text-color = c.subtext0;
              disabled-text-color = c.overlay0;
              rgb-primary-text-color = "202, 211, 245";

              primary-background-color = c.base;
              secondary-background-color = c.mantle;
              lovelace-background = c.base;
              card-background-color = c.base;
              ha-card-background = c.base;
              # popups and menus need a step up or they vanish into the page
              ha-dialog-surface-background = c.crust;
              mdc-theme-surface = c.crust;

              app-header-background-color = c.base;
              app-header-text-color = c.text;
              sidebar-background-color = c.base;
              sidebar-text-color = c.subtext0;
              sidebar-icon-color = c.subtext0;
              sidebar-selected-text-color = c.pink;
              sidebar-selected-icon-color = c.pink;

              border-color = c.surface0;
              divider-color = c.surface0;
              outline-color = c.surface1;

              state-icon-color = c.lavender;
              state-active-color = c.pink;
              state-on-color = c.pink;
              state-off-color = c.overlay0;
              state-unavailable-color = c.surface1;

              error-color = c.red;
              warning-color = c.peach;
              success-color = c.green;
              info-color = c.blue;

              switch-checked-color = c.pink;
              switch-checked-button-color = c.pink;
              switch-checked-track-color = c.mauve;
              switch-unchecked-button-color = c.overlay0;
              switch-unchecked-track-color = c.surface0;
              paper-slider-knob-color = c.pink;
              paper-slider-active-color = c.pink;
              paper-slider-container-color = c.surface0;

              mush-rgb-state-light = "238, 212, 159"; # yellow
              mush-rgb-red = "237, 135, 150";
              mush-rgb-pink = "245, 189, 230";
              mush-rgb-purple = "198, 160, 246";
              mush-rgb-blue = "138, 173, 244";
              mush-rgb-light-blue = "145, 215, 227";
              mush-rgb-cyan = "145, 215, 227";
              mush-rgb-teal = "139, 213, 202";
              mush-rgb-green = "166, 218, 149";
              mush-rgb-yellow = "238, 212, 159";
              mush-rgb-orange = "245, 169, 127";
              mush-rgb-grey = "110, 115, 141";
              mush-rgb-disabled = "73, 77, 100";

              mush-title-padding = "12px 12px 6px";
              ha-card-box-shadow = "inset 0px 0px 0px 1px var(--border-color)";
              ha-card-border-color = "rgba(0,0,0,0)";
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

      matterjs-server = {
        enable = true;
        extraArgs = [
          "--enable-time-sync"
          # our devices are paired to a fabric created by python-matter-server,
          # which uses vendor id 4939 (0x134B), not matter.js's default 0xFFF1.
          # if these don't match, the server ignores that fabric and starts a
          # new empty one, so every device disappears
          "--vendorid=4939"
        ];
      };

      openthread-border-router = mkIf thread {
        enable = true;
        radio = {
          device = cfg.radio;
          # the MG24's thread firmware (SL-OPENTHREAD 2.4.4.0) talks 115200 and CTS is never raised so flow control would block every write
          baudRate = 115200;
          flowControl = false;
        };
      };
    };

    systemd = {
      services.matterjs-server.environment.TZ = "Asia/Kolkata";

      tmpfiles.rules = map (f: "f ${hassDir}/${f} 0644 hash hash") [
        "automations.yaml"
        "scenes.yaml"
        "scripts.yaml"
      ];
    };
  };
}
