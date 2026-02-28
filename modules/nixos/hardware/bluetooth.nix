{ lib, config, ... }:

let
  inherit (lib.modules) mkIf;
  inherit (lib.options) mkEnableOption;

  cfg = config.pixel.system.bluetooth;
in

{
  options.pixel = {
    device.capabilities.bluetooth = mkEnableOption "bluetooth" // {
      default = true;
    };

    system.bluetooth.enable = mkEnableOption "load drivers";
  };

  # https://wiki.nixos.org/wiki/Bluetooth
  config = mkIf cfg.enable {
    hardware.bluetooth = {
      enable = true;

      disabledPlugins = [
        "sap"
        "handsfree"
      ];

      # https://github.com/bluez/bluez/blob/master/src/main.conf
      settings = {
        General = {
          JustWorksRepairing = "always";
          MultiProfile = "multiple";

          # https://wiki.nixos.org/wiki/Bluetooth#Enabling_A2DP_Sink
          Enable = "Source,Sink,Media,Socket";

          FastConnectable = true;

          # experimental features expose HFP codec negotiation & battery level reporting [BAS] for the headset
          Experimental = true;
          KernelExperimental = true;
        };

        Policy = {
          AutoEnable = true;

          ReconnectAttempts = 7;
          ReconnectIntervals = "1, 2, 4, 8, 16, 32, 64";
        };
      };
    };

    boot.kernelModules = [ "btusb" ];
  };
}
