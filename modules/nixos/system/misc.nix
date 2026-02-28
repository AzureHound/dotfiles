{
  lib,
  pkgs,
  config,
  ...
}:

let
  inherit (lib.modules) mkIf;
in

{
  config = mkIf config.pixel.profiles.graphical.enable {
    services = {
      dbus = {
        enable = true;
        packages = with pkgs; [ gcr_4 ];
      };

      gnome.sushi.enable = true;
      gvfs.enable = true;

      samba = {
        enable = true;
        nmbd.enable = false;
      };

      udisks2.enable = true;
    };
  };
}
