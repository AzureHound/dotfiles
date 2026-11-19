{
  lib,
  pkgs,
  config,
  ...
}:

let
  inherit (lib.modules) mkIf mkMerge;
  inherit (lib.options) mkEnableOption;

  cfg = config.pixel.system.virtualization;
  win = config.pixel.system.virtualization.windows;
in

{
  options.pixel.system.virtualization.enable = mkEnableOption "virtualization";

  config = mkMerge [
    (mkIf (cfg.enable || win.enable) {
      boot = {
        kernelModules = [ "vhost_net" ];

        kernel.sysctl = {
          "net.ipv4.ip_forward" = 1;
          "net.ipv6.conf.all.forwarding" = 1;
        };
      };

      networking.firewall.trustedInterfaces = [ "virbr0" ];

      virtualisation.libvirtd = {
        enable = true;
        qemu = {
          package = pkgs.qemu_kvm;
          swtpm.enable = true;
        };
      };
    })

    (mkIf cfg.enable {
      programs.virt-manager.enable = true;
    })
  ];
}
