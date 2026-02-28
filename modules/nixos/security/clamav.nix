{
  services.clamav = {
    daemon.enable = true;
    updater.enable = true;
    scanner = {
      enable = true;
      interval = "Mon *-*-* 00:00:00";
    };
  };
}
