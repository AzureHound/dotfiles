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
  config = mkIf config.pixel.profiles.graphical.enable {
    programs.swayimg = {
      enable = config.pixel.profiles.graphical.enable && pkgs.stdenv.hostPlatform.isLinux;
    };

    xdg.configFile = mkCfgLink [ "swayimg/init.lua" ];
  };
}
