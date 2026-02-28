{
  security = {
    run0 = {
      enable = true;

      wheelNeedsPassword = true;
      sudo-shim.enable = true;
    };

    sudo.enable = false;
    sudo-rs.enable = false;
  };
}
