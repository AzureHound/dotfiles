{ lib, config, ... }:

let
  inherit (lib.modules) mkDefault mkForce;
in

{
  imports = [
    ./blocker.nix
    ./fail2ban.nix
    ./firewall.nix
    ./fleet.nix
    ./networkmgr.nix
    ./openssh.nix
    ./optimise.nix
    ./systemd.nix
    ./tailscale.nix
    # ./vpn.nix
    ./wireless.nix
  ];

  networking = {
    # generate a host ID by hashing the hostname
    hostId = builtins.substring 0 8 (builtins.hashString "md5" config.networking.hostName);

    useDHCP = mkForce false;
    useNetworkd = mkForce true;
    usePredictableInterfaceNames = mkDefault true;

    # dns
    nameservers = [
      "1.1.1.1"
      "1.0.0.1"
      "2606:4700:4700::1111"
      "2606:4700:4700::1001"

      "9.9.9.9"
      "149.112.112.112"
      "2620:fe::fe"
      "2620:fe::9"
    ];
  };
}
