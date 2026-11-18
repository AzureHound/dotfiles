{
  lib,
  pkgs,
  config,
  mkCfgLink,
  ...
}:

let
  inherit (lib.modules) mkIf;
in

{
  config = mkIf config.pixel.profiles.development.enable {
    sops.secrets.ha_token = { };

    programs.mise = {
      enable = true;

      globalConfig = {
        tools = {
          "go:github.com/josephburgess/gust/cmd/gust" = "latest";

          # "npm:@excalidraw/cli" = "latest";
          "npm:czg" = "latest";
          "npm:five-server" = "latest";
          "npm:torlnk" = "latest";

          "pipx:hastty" = "latest";
        };

        settings = {
          idiomatic_version_file_enable_tools = [ "node" ];

          always_keep_download = false;
          always_keep_install = false;

          minimum_release_age = "2d";

          trusted_config_paths = [ "~/Developer" ];

          verbose = false;
          http_timeout = "30s";
          jobs = 4;
          raw = false;
          yes = false;

          not_found_auto_install = true;
          paranoid = false;

          disable_default_registry = false;
          disable_tools = [ "node" ];

          experimental = true;

          status = {
            missing_tools = "if_other_versions_installed";
            show_env = false;
            show_tools = false;
          };
        };

        env = {
          "_" = {
            file = ".env";
          };
        };
      };
    };

    home = {
      activation.syncMise = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        export PATH="${
          lib.makeBinPath (
            with pkgs;
            [
              go
              nodejs
              pipx
            ]
          )
        }:$PATH"
      '';

      packages = with pkgs; [ pipx ];

      sessionVariables = {
        HA_URL = "http://10.10.0.4:8123";
        HA_TOKEN = "$(cat ${config.sops.secrets.ha_token.path})";
      };

      shellAliases = {
        cz = "czg";
        ha = "hastty";
        wttr = "gust -f";
      };
    };

    xdg.configFile = mkCfgLink [ "mise/templates" ];
  };
}
