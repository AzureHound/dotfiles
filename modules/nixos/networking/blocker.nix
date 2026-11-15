{ config, ... }:

{
  networking.stevenblack = {
    enable = !config.pixel.profiles.server.enable && !config.pixel.system.networking.useRouterDns;

    block = [
      "fakenews"
      "gambling"
      # "porn"
      # "social"
    ];
  };
}
