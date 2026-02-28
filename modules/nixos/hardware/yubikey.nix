{
  lib,
  pkgs,
  config,
  ...
}:

let
  inherit (lib.modules) mkIf;
  inherit (lib.options) mkEnableOption;
in

{
  options.pixel.device.capabilities.yubikey = mkEnableOption "yubikey";

  config = mkIf config.pixel.device.capabilities.yubikey {
    services = {
      pcscd.enable = true;
      udev.packages = with pkgs; [ yubikey-personalization ];
    };

    hardware.gpgSmartcards.enable = true;

    environment.systemPackages = with pkgs; [ yubikey-manager ];
  };
}
