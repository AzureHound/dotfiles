{ config, ... }:

{
  security = {
    polkit = {
      enable = true;

      # enablePkexecWrapper = false;
    };

    # soteria.enable = config.pixel.profiles.graphical.enable;
  };
}
