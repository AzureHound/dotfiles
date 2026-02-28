{
  security = {
    # protectKernelImage = true; # read-only kernel image
    lockKernelModules = false; # breaks virtd, wireguard & iptables

    # force-enable PTI Linux kernel feature
    forcePageTableIsolation = true;

    # User namespaces are required for sandboxing.
    # Can't set `"user.max_user_namespaces" = 0;` in sysctl
    allowUserNamespaces = true;

    # Disable unprivileged user namespaces, unless containers are enabled
    unprivilegedUsernsClone = false;

    allowSimultaneousMultithreading = true;
  };
}
