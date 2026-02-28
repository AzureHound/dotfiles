{
  lib,
  self,
  pkgs,
  config,
  mkCfgLink,
  ...
}:

let
  inherit (lib.modules) mkIf;

  cfg = "${self}/config/configHome/rmpc";
in

{
  config = mkIf config.pixel.profiles.media.listening.enable {
    programs.rmpc = {
      enable = true;

      config = builtins.readFile "${cfg}/config.ron";
    };

    xdg = {
      configFile = mkCfgLink [ "rmpc/themes" ];

      desktopEntries = mkIf pkgs.stdenv.hostPlatform.isLinux {
        rmpc = {
          name = "rmpc";
          noDisplay = true;
        };
      };
    };
  };
}
