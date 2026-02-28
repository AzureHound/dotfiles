{ lib, config, ... }:

let
  inherit (lib.modules) mkIf;
in

{
  # https://chrisdown.name/2026/03/24/zswap-vs-zram-when-to-use-what.html
  boot = {
    zswap = {
      enable = config.swapDevices != [ ];

      maxPoolPercent = mkIf config.pixel.profiles.server.enable 15;
    };
  };
}
