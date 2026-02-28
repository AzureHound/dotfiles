{ config, ... }:

{
  networking.stevenblack = {
    enable = !config.pixel.profiles.server.enable;

    block = [
      "fakenews"
      "gambling"
      # "porn"
      # "social"
    ];
  };
}
