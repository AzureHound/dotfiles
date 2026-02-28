{ lib, ... }:

let
  inherit (lib.modules) mkDefault;
in

{
  systemd = {
    # Systemd OOMd
    oomd = {
      enable = true;

      # https://src.fedoraproject.org/rpms/systemd/tree/acb90c49c42276b06375a66c73673ac3510255
      enableRootSlice = true;
      enableUserSlices = true;
      enableSystemSlice = true;
      settings.OOM.DefaultMemoryPressureDurationSec = "20s";
    };

    services.nix-daemon.serviceConfig.OOMScoreAdjust = mkDefault 350;

    tmpfiles.settings."10-oomd-root" = {
      # Keep kernel log [ including stack trace ] into pstore upon panic or crash.
      "/sys/module/kernel/parameters/crash_kexec_post_notifiers".w = {
        argument = "Y";
      };

      # Keep kernel log upon normal [ shutdown, reboot & halt ].
      "/sys/module/printk/parameters/always_kmsg_dump".w = {
        argument = "N";
      };
    };
  };
}
