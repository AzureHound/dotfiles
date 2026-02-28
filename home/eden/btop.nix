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
  config = mkIf config.pixel.profiles.workstation.enable {
    programs.btop = {
      enable = true;

      settings = {
        vim_keys = true;
      };
    };

    xdg.desktopEntries = mkIf pkgs.stdenv.hostPlatform.isLinux {
      btop = {
        name = "btop++";
        noDisplay = true;
      };
    };
  };
}
