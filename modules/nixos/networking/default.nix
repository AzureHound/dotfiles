{ lib, config, ... }:

let
  inherit (lib.modules) mkDefault mkForce;
  inherit (lib.lists) optionals;
  inherit (lib.options) mkEnableOption;
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
    ./relay.nix
    ./systemd.nix
    ./tailscale.nix
    # ./vpn.nix
    ./wireless.nix
  ];

  options.pixel.system.networking.useRouterDns = mkEnableOption "use DNS servers handed out by DHCP";

  config.networking = {
    # generate a host ID by hashing the hostname
    hostId = builtins.substring 0 8 (builtins.hashString "md5" config.networking.hostName);

    useDHCP = mkForce false;
    useNetworkd = mkForce true;
    usePredictableInterfaceNames = mkDefault true;

    # dns
    nameservers = optionals (!config.pixel.system.networking.useRouterDns) [
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
