{
  lib,
  pkgs,
  config,
  ...
}:

let
  inherit (lib.modules) mkIf;
  inherit (lib.options) mkEnableOption;

  cfg = config.pixel.system.virtualization.windows;
in

{
  options.pixel.system.virtualization.windows.enable = mkEnableOption "windows";

  config = mkIf cfg.enable {
    pixel.services.docker.enable = true;

    environment.systemPackages = [ pkgs.iptables ];

    networking.firewall = {
      allowedTCPPorts = [
        8006
        3389
      ];
      allowedUDPPorts = [ 3389 ];
      trustedInterfaces = [ "lan" ];

      extraForwardRules = ''
        iifname "enp7s0" oifname "lan" accept
        iifname "lan" oifname "enp7s0" accept
      '';
    };
  };
}
