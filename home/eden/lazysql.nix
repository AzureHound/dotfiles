{ config, ... }:

{
  programs.lazysql = {
    inherit (config.pixel.profiles.development) enable;
  };
}
