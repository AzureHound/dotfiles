{ lib, config, ... }:

let
  inherit (lib.modules) mkIf;
  inherit (lib.options) mkEnableOption;

  cfg = config.pixel.profiles.hetzner;
in

{
  options.pixel.profiles.hetzner.enable = mkEnableOption "Hetzner Cloud profile";

  config = mkIf cfg.enable {
    pixel = {
      device.capabilities = {
        tpm = false;
        bluetooth = false;
      };

      system.boot = {
        loader = "grub";
        grub.device = "/dev/sda";
        tmpOnTmpfs = false;
      };
    };
  };
}
