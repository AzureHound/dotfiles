{
  lib,
  pkgs,
  config,
  inputs,
  ...
}:

let
  inherit (lib.modules) mkIf;
in

{
  imports = [
    inputs.noctalia.homeModules.default
  ];

  config = mkIf (pkgs.stdenv.hostPlatform.isLinux && config.pixel.profiles.graphical.enable) {
    programs = {
      noctalia = {
        systemd.enable = true;

        settings = {
          theme = {
            mode = "dark";
            source = "builtin";
            builtin = "Catppuccin Macchiato";
          };

          wallpaper = {
            enabled = false;
          };
        };
      };

      quickshell.enable = true;
    };
  };
}
