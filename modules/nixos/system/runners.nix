{
  lib,
  pkgs,
  config,
  ...
}:

let
  inherit (lib.attrsets) genAttrs;
  inherit (lib.modules) mkIf;
  inherit (lib.options) mkEnableOption;

  cfg = config.pixel.system.security.binaries;
in

{
  options.pixel.system.security = {
    binaries.enable = mkEnableOption "Run unpatched linux binaries";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ appimage-run ];

    # Appimage
    boot.binfmt.registrations =
      genAttrs
        [
          "appimage"
          "AppImage"
        ]
        (ext: {
          recognitionType = "extension";
          magicOrExtension = ext;
          interpreter = "/run/current-system/sw/bin/appimage-run";
        });

    # Run unpatched linux binaries
    programs.nix-ld = {
      enable = true;

      libraries = with pkgs; [
        curl
        glib
        glibc
        icu
        libsecret
        libunwind
        libuuid
        openssl
        util-linux
        zlib

        # graphical
        freetype
        gdk-pixbuf
        libglvnd
        libnotify
        libx11
        sdl3
        vulkan-loader

        stdenv.cc.cc
        stdenv.cc.cc.lib
      ];
    };
  };
}
