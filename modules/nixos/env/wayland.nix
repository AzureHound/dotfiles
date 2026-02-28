{ lib, config, ... }:

let
  inherit (lib.modules) mkIf;
in

{
  config = mkIf config.pixel.profiles.graphical.enable {
    environment.variables = {
      _JAVA_AWT_WM_NONEREPARENTING = "1";
      CLUTTER_BACKEND = "wayland";
      ELECTRON_OZONE_PLATFORM_HINT = "wayland";
      EGL_PLATFORM = "wayland";
      NIXOS_OZONE_WL = "1";

      # FIREFOX
      MOZ_DISABLE_RDD_SANDBOX = "1";
      MOZ_ENABLE_WAYLAND = "1";

      # GTK
      GDK_SCALE = 1;
      GDK_BACKEND = "wayland,x11";
    };
  };
}
