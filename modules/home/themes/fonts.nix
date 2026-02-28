{
  lib,
  pkgs,
  config,
  inputs,
  ...
}:

let
  inherit (lib.lists) optionals;
  inherit (lib.modules) mkIf;
  inherit (lib.options) mkOption mkEnableOption;
  inherit (lib.types)
    str
    int
    nullOr
    package
    ;

  cfg = config.pixel.style.fonts;
in

{
  options.pixel.style.fonts = {
    enable = mkEnableOption "fontconfig" // {
      default = config.pixel.profiles.graphical.enable;
    };

    name = mkOption {
      type = str;
      default = "Josefin Sans";
    };

    monospace = mkOption {
      type = str;
      default = "Maple Mono";
    };

    italic = mkOption {
      type = str;
      default = "Josefin Sans Italic";
    };

    bold = mkOption {
      type = str;
      default = "Josefin Sans Bold";
    };

    bold-italic = mkOption {
      type = str;
      default = "Josefin Sans Bold Italic";
    };

    package = mkOption {
      type = nullOr package;
      default = null;
    };

    size = mkOption {
      type = int;
      default = 12;
    };
  };

  config = mkIf cfg.enable {
    fonts.fontconfig = {
      enable = true;

      defaultFonts = {
        monospace = [
          cfg.monospace

          # primary latin fallbacks
          "SFMono Nerd Font"
          "Source Code Pro"

          # unicode
          "Noto Sans Mono"
          "Noto Sans"
          "Noto Serif"

          # CJK
          "Noto Sans CJK JP"
          "Noto Sans CJK SC"
          "Noto Sans CJK TC"
          "Noto Sans CJK KR"

          # icons
          "Material Icons"
          "Material Design Icons"

          # final fallback
          "DejaVu Sans Mono"
        ];

        sansSerif = [
          cfg.name

          # primary latin fallbacks
          "Maple Mono"
          "SFProDisplay Nerd Font"
          "Inter"
          "Source Sans 3"

          # unicode
          "Noto Sans"

          # CJK
          "Noto Sans CJK JP"
          "Noto Sans CJK SC"
          "Noto Sans CJK TC"
          "Noto Sans CJK KR"

          # icons
          "Material Icons"
          "Material Design Icons"

          # final fallback
          "DejaVu Sans"
        ];

        serif = [
          cfg.name

          # latin serif
          "Maple Mono"
          "Source Serif 4"
          "SFRounded Nerd Font"

          # unicode
          "Noto Serif"

          # CJK
          "Noto Serif CJK JP"
          "Noto Serif CJK SC"
          "Noto Serif CJK TC"
          "Noto Serif CJK KR"

          # icons
          "Material Icons"
          "Material Design Icons"

          # final fallback
          "DejaVu Serif"
        ];

        emoji = [
          "Twemoji Color Font"
          "Noto Color Emoji"
        ];
      };
    };

    home.packages = optionals pkgs.stdenv.hostPlatform.isLinux (
      with inputs.apple-fonts.packages.${pkgs.stdenv.hostPlatform.system};
      [
        sf-pro-nerd
        sf-mono-nerd
      ]
    );
  };
}
