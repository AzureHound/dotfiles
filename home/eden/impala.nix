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
  config = mkIf (pkgs.stdenv.hostPlatform.isLinux && config.pixel.profiles.graphical.enable) {
    programs.impala = {
      enable = true;

      settings = {
        ascii = true;
        esc_quit = true;
        mode = "station";

        theme = {
          background = "dark gray";
          border = "green";
          text_color = "white";
          hidden_color = "dark gray";
          info_color = "green";
          warning_color = "yellow";
          error_color = "red";
        };
      };
    };
  };
}
