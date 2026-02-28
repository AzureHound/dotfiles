{
  nix = {
    gc.dates = "weekly";

    optimise = {
      automatic = true;
      dates = [ "daily" ];
    };

    # daemonCPUSchedPolicy = "idle";
    # daemonIOSchedClass = "idle";
    # daemonIOSchedPriority = 7;

    settings = {
      use-cgroups = true;
      auto-allocate-uids = true;

      # https://github.com/NixOS/nixpkgs/issues/293114#issuecomment-2663470083
      # build-dir = "/var/tmp";
    };
  };
}
