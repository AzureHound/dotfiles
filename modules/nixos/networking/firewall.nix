{ lib, config, ... }:

let
  inherit (lib.modules) mkForce;
in

{
  config = {
    # https://github.com/evilsocket/opensnitch/blob/master/daemon/default-config.json
    # services.opensnitch.enable = device.type != "server"; # TODO:

    networking = {
      nftables.enable = true;

      firewall = {
        enable = true;

        allowedTCPPorts = [ ];
        allowedUDPPorts = [ ];

        allowedTCPPortRanges = [ ];
        allowedUDPPortRanges = [ ];

        allowPing = config.pixel.profiles.server.enable;

        logReversePathDrops = true;
        logRefusedConnections = false;

        checkReversePath = mkForce false; # don't filter DHCP packets
      };
    };
  };
}
