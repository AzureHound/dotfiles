{
  lib,
  pkgs,
  config,
  ...
}:

let
  inherit (lib.modules) mkIf;
  inherit (pkgs.stdenv.hostPlatform) isLinux;
in

{
  programs.zathura = {
    enable = config.pixel.profiles.graphical.enable && isLinux;

    package = pkgs.symlinkJoin {
      name = "zathura-webp";
      paths = [ pkgs.zathura ];
      nativeBuildInputs = [ pkgs.makeWrapper ];
      postBuild = ''
        wrapProgram $out/bin/zathura \
          --set GDK_PIXBUF_MODULE_FILE "${
            pkgs.runCommand "loaders.cache" { nativeBuildInputs = [ pkgs.gdk-pixbuf ]; }
              "gdk-pixbuf-query-loaders ${pkgs.gdk-pixbuf}/lib/gdk-pixbuf-2.0/*/loaders/*.so ${pkgs.webp-pixbuf-loader}/lib/gdk-pixbuf-2.0/*/loaders/*.so > $out"
          }" \
          --prefix PATH : "${pkgs.libarchive}/bin"
      '';
    };

    options = {
      adjust-open = "width";
      pages-per-row = 1;

      scroll-page-aware = true;
      scroll-full-overlap = "0.01";
      scroll-step = 100;

      zoom-min = 10;
      guioptions = "";
      render-loading = false;

      font = "Maple Mono 10.5";

      selection-clipboard = "clipboard";
      window-title-page = true;

      recolor = true;
      recolor-keephue = true;
      recolor-reverse-video = true;

      database = "sqlite";

      window-title-home-tilde = true;
      statusbar-home-tilde = true;
    };

    mappings = {
      f = "toggle_fullscreen";
      "[fullscreen] f" = "toggle_fullscreen";
      a = "toggle_statusbar";
      c = "recolor";
      "[fullscreen] c" = "recolor";
    };

    extraConfig = ''
      unmap f
      unmap a
    '';
  };

  xdg.desktopEntries = mkIf isLinux {
    "org.pwmt.zathura" = {
      name = "Zathura";
      noDisplay = true;
    };
  };
}
