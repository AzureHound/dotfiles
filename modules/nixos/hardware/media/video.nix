{ config, ... }:

{
  hardware.graphics.enable = config.pixel.profiles.graphical.enable || config.pixel.device.gpu != null;
}
