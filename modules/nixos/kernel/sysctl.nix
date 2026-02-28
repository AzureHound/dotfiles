# > sudo sysctl -a > sysctl.txt
# > kernel-hardening-checker -l /proc/cmdline -c /proc/config.gz -s ./sysctl.txt

# https://docs.kernel.org/admin-guide/sysctl/vm.html
# https://sysctl-explorer.net/

{ config, ... }:

{
  boot.kernel.sysctl = {
    # The Magic SysRq key is a key combo that allows users connected to the
    # system console of a Linux kernel to perform some low-level commands.
    "kernel.sysrq" = 0;

    # Restrict ptrace() usage to processes with a pre-defined relationship
    "kernel.yama.ptrace_scope" = 3;

    # Hide kptrs even for processes with CAP_SYSLOG
    "kernel.kptr_restrict" = 2;

    # Disable bpf() JIT [eliminate spray attacks]
    # To use scx scheduler, bpf_jit can't be disabled
    # https://github.com/isabelroses/dotfiles/issues/591
    "net.core.bpf_jit_enable" = config.services.scx.enable;

    # Disable ftrace debugging
    "kernel.ftrace_enabled" = false;

    # Avoid kernel memory address exposures via dmesg [this can also be set by CONFIG_SECURITY_DMESG_RESTRICT].
    "kernel.dmesg_restrict" = 1;

    # Disable SUID binary dump
    "fs.suid_dumpable" = 0;

    # Disable late module loading
    # "kernel.modules_disabled" = 1;

    # Disallow profiling at all levels without CAP_SYS_ADMIN
    "kernel.perf_event_paranoid" = 3;

    # Require CAP_BPF to use bpf
    "kernel.unprivileged_bpf_disabled" = true;

    # Prevent boot console log leaking information
    "kernel.printk" = "3 3 3 3";

    # Restrict loading TTY line disaciplines to the CAP_SYS_MODULE capablitiy to
    # prevent unprvileged attackers from loading vulnrable line disaciplines
    "dev.tty.ldisc_autoload" = 0;

    # Patches potential security hole.
    "kernel.kexec_load_disabled" = true;

    # Disable TIOCSTI ioctl, which allows a user to insert characters into the input queue of a terminal
    "dev.tty.legacy_tiocsti" = 0;

    # Disable the ability to load kernel modules.
    # "kernel.modules_disabled" = 1; # BUG: breaks boot

    # This enables hardening for the BPF JIT compiler, however it comes at a performance cost
    # "net.core.bpf_jit_harden" = 2;

    # https://github.com/NixOS/nixpkgs/pull/391473/

    # Mitigate some TOCTOU vulnerabilities
    # cf. https://www.kernel.org/doc/Documentation/admin-guide/sysctl/fs.rst

    # Don’t allow O_CREAT open on FIFOs not owned by the user in world- or
    # group‐writable sticky directories [e.g. /tmp], unless owned by the directory owner
    "fs.protected_fifos" = 2;

    # Don’t allow users to create hardlinks unless they own the source file or have read/write access to it
    "fs.protected_hardlinks" = 1;

    # Don’t allow O_CREAT open on regular files not owned by user in world
    # or group‐writable sticky directories [e.g. /tmp], unless owned by the directory owner
    "fs.protected_regular" = 2;

    # Don’t follow symlinks in sticky world‐writable directories [e.g. /tmp],
    # unless the user ID of the follower matches the symlink or the directory owner matches the symlink
    "fs.protected_symlinks" = 1;

    # increase the map count for apps that require a lot of memory mappings like games & emulators
    "vm.max_map_count" = 2147483642;

    # Enable IPv4 packet forwarding for routing apps like VPNs, VMs, & containers
    "net.ipv4.conf.all.forwarding" = true;
  };
}
