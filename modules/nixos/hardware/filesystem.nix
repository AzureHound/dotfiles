{ config, ... }:

{
  services = {
    fstrim = {
      enable = true;
      interval = "weekly";
    };

    btrfs.autoScrub = {
      enable = config.boot.supportedFilesystems.btrfs or false;
      interval = "weekly";
      fileSystems = [ "/" ];
    };
  };
}
