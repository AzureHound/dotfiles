{ config, ... }:

{
  programs.zoxide = {
    inherit (config.pixel.profiles.workstation) enable;

    options = [ "--cmd cd" ];
  };
}
