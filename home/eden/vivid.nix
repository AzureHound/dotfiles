{ config, ... }:

{
  programs.vivid = {
    inherit (config.pixel.profiles.graphical) enable;
  };
}
