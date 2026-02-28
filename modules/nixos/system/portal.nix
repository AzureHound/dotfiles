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

    config = {
      common = {
        default = [ "gtk" ];

        "org.freedesktop.impl.portal.Secret" = [ "gnome-keyring" ];
      };
    };

    extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
  };
}
