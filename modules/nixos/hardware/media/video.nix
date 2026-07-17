{
  self,
  pkgs,
  config,
  ...
}:

let
  inherit (self.lib) isx86Linux;
in

{
  hardware.graphics = {
    enable = true;

    enable32Bit = config.pixel.profiles.graphical.enable && isx86Linux pkgs;
  };
}
