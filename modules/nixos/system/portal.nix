{
  lib,
  pkgs,
  config,
  ...
}:

let
  inherit (lib.modules) mkDefault;
in

{
  xdg.portal = {
    enable = mkDefault config.pixel.profiles.graphical.enable;

    xdgOpenUsePortal = true;

    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-termfilechooser
    ];

    config.common = {
      default = [ "gtk" ];

      "org.freedesktop.impl.portal.FileChooser" = [ "termfilechooser" ];
      "org.freedesktop.impl.portal.Secret" = [ "oo7-portal" ];
    };
  };
}
