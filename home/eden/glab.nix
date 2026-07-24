{
  lib,
  pkgs,
  config,
  ...
}:

let
  inherit (lib.modules) mkIf;
in

{
  config = mkIf config.pixel.profiles.development.enable {
    home = {
      packages = with pkgs; [
        glab
      ];

      shellAliases = {
        gl = "glab";
      };
    };

    sops = {
      secrets.gl = { };

      templates = {
        "glab-config.yml" = {
          path = "${config.home.homeDirectory}/.config/glab-cli/config.yml";
          mode = "0600";
          content = ''
            git_protocol: ssh
            check_update: false
            display_hyperlinks: true

            hosts:
              gitlab.com:
                token: ${config.sops.placeholder.gl}
                api_host: gitlab.com
                api_protocol: https
                git_protocol: ssh
          '';
        };

        "glab-aliases.yml" = {
          path = "${config.home.homeDirectory}/.config/glab-cli/aliases.yml";
          mode = "0600";
          content = ''
            ci: pipeline ci
            co: mr checkout
          '';
        };
      };
    };
  };
}
