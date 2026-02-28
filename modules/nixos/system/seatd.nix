{ config, ... }:

{
  services.seatd = {
    inherit (config.pixel.profiles.graphical) enable;
  };
}
