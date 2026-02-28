{ lib, config, ... }:

let
  inherit (lib.modules) mkIf;
in

{
  config = mkIf config.pixel.profiles.graphical.enable {
    programs = {
      dconf.enable = true;
      gpu-screen-recorder.enable = true;
      seahorse.enable = true; # gnome's keyring manager
    };
  };
}
