{ lib, ... }:

let
  inherit (lib.options) mkEnableOption;
in

{
  options.pixel.profiles = {
    graphical.enable = mkEnableOption "Graphical Interface";
    headless.enable = mkEnableOption "Headless";
    workstation.enable = mkEnableOption "Workstation";
    gaming.enable = mkEnableOption "Gaming";
    laptop.enable = mkEnableOption "Laptop";
    server.enable = mkEnableOption "Server";
  };
}
