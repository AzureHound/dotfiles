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
  config = mkIf config.pixel.profiles.graphical.enable {
    hardware.i2c.enable = true;

    boot = {
      kernelModules = [ "ddcci_backlight" ];
      extraModulePackages = [ config.boot.kernelPackages.ddcci-driver ];
    };

    environment.systemPackages = with pkgs; [ ddcutil ];
    services.udev.packages = with pkgs; [ ddcutil ];
  };
}
