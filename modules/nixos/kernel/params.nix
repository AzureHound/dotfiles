# https://www.kernel.org/doc/html/latest/admin-guide/kernel-parameters.html

{ lib, config, ... }:

let
  inherit (lib.lists) optionals;
  inherit (lib.options) mkEnableOption;

  cfg = config.pixel.system;
in

{
  options.pixel.system = {
    boot.silent = mkEnableOption ''
      silent boot process through `quiet` kernel parameter
    '';

    kernel.tweaks.enable = mkEnableOption "security & performance related kernel parameters" // {
      default = true;
    };
  };

  config.boot.kernelParams = [
    # NixOS produces many wakeups per second, which is bad for battery life.
    # This kernel parameter disables the timer tick on the last 4 cores
    # "nohz_full=4-7"

    # make stack-based attacks on the kernel harder
    "randomize_kstack_offset=on"

    # controls the behavior of vsyscalls. this has been defaulted to none back in 2016 - break really old binaries for security
    "vsyscall=none"

    # reduce most of the exposure of a heap attack to a single cache
    "slab_nomerge"

    # Disable debugfs which exposes sensitive kernel data
    "debugfs=off"

    # Sometimes certain kernel exploits will cause what is called an "oops" which is a kernel panic
    # that is recoverable. This will make it unrecoverable, & therefore safe to those attacks
    "oops=panic"

    # only allow signed modules
    # "module.sig_enforce=1"

    # blocks access to all kernel memory, even preventing administrators from being able to inspect & probe the kernel
    "lockdown=confidentiality"
    # "lockdown=integrity"

    # enable buddy allocator free poisoning
    # "page_poison=on"

    # performance improvement for direct-mapped memory-side-cache utilization, reduces the predictability of page allocations
    "page_alloc.shuffle=1"

    # for debugging kernel-level slab issues
    # "slub_debug=FZP"

    # disable sysrq keys. sysrq is seful for debugging, but also insecure
    "sysrq_always_enabled=0" # 0 | 1

    # ignore access time [atime] updates on files, except when they coincide with updates to the ctime or mtime
    "rootflags=noatime"

    # linux security modules
    "lsm=landlock,lockdown,yama,integrity,apparmor,bpf,tomoyo,selinux"

    # prevent the kernel from blanking plymouth out of the fb
    "fbcon=nodefer"
  ]
  ++ optionals cfg.kernel.tweaks.enable [
    # https://en.wikipedia.org/wiki/Kernel_page-table_isolation
    # auto means kernel will automatically decide the pti state
    "pti=auto" # on || off

    # NOTE: do NOT add "idle=nomwait" here. It disables MWAIT, which forces the
    # kernel off intel_idle onto acpi_idle, whose coarse ACPI C-states have huge
    # exit latencies (~1ms C3 on Alder Lake). That wakeup latency causes audio
    # xruns (crackle) & network stalls at idle. intel_idle gives fine-grained,
    # low-latency C-states & is the correct driver on modern Intel.

    # enable IOMMU for devices used in passthrough & provide better host performance
    "iommu=pt"

    # disable usb autosuspend
    "usbcore.autosuspend=-1"

    # resume & restores original swap space
    # "noresume"

    # allow systemd to set & save the backlight state
    "acpi_backlight=native"

    # prevent the kernel from blanking plymouth out of the fb
    "fbcon=nodefer"

    # disable boot logo
    "logo.nologo"

    # disable the cursor in vt to get a black screen during intermissions
    "vt.global_cursor_default=0"
  ]
  ++ optionals cfg.boot.silent [
    # tell the kernel to not be verbose, the voices are too loud
    "quiet"

    # enable graphical boot splash screen
    "splash"

    # kernel log message level
    "loglevel=3" # 1: system is unusable | 3: error condition | 7: very verbose

    # udev log message level
    "udev.log_level=3"

    # lower the udev log level to show only errors or worse
    "rd.udev.log_level=3"

    # disable systemd status messages
    "systemd.show_status=auto"

    # rd prefix means systemd-udev will be used instead of initrd
    "rd.systemd.show_status=auto"
  ]
  ++ optionals config.pixel.profiles.headless.enable [
    "panic=1"
    "boot.panic_on_fail"
    "vga=0x317"
    "nomodeset"
  ];
}
