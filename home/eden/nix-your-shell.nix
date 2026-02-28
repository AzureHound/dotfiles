{ config, ... }:

{
  programs.nix-your-shell = {
    inherit (config.pixel.profiles.workstation) enable;
  };
}
