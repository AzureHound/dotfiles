{ lib, config, ... }:

let
  inherit (lib.modules) mkIf;
in

{
  networking.networkmanager = {
    enable = true;

    dns = "systemd-resolved";
    unmanaged = [
      "interface-name:tailscale*"
      "interface-name:br-*"
      "interface-name:docker*"
      "interface-name:virbr*"
      "interface-name:ve-*"
      "type:bridge"
    ];

    wifi = {
      backend = "iwd";
      powersave = config.pixel.profiles.laptop.enable;

      macAddress = "random";
      scanRandMacAddress = true;
    };

    # ethernet.macAddress = mkIf (!config.pixel.profiles.server.enable) "random";
  };
}
