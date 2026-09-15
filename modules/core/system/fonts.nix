{
  lib,
  self,
  pkgs,
  _class,
  config,
  ...
}:

let
  inherit (lib.lists) optionals;
  inherit (lib.modules) mkIf;

  fontPath = "${self}/config/home/.local/share/fonts";
  install = font: ''
    mkdir -p $out/share/fonts/truetype
    cp $src $out/share/fonts/truetype/${font}
  '';
in

{
  config = mkIf config.pixel.profiles.graphical.enable {
    fonts.packages =
      with pkgs;
      [
        corefonts

        source-sans
        source-serif

        dejavu_fonts
        inter

        noto-fonts

        noto-fonts-cjk-sans
        noto-fonts-cjk-serif

        noto-fonts-color-emoji
        material-icons
        material-design-icons
        twemoji-color-font

        maple-mono.truetype
      ]

      ++ (with pkgs.nerd-fonts; [
        jetbrains-mono
        symbols-only
      ])

      ++ optionals (_class == "darwin") [
        (stdenvNoCC.mkDerivation {
          name = "josefin-sans";
          src = "${fontPath}/JosefinSans";
          dontUnpack = true;
          installPhase = ''
            mkdir -p $out/share/fonts/truetype
            cp -r $src/* $out/share/fonts/truetype/
          '';
        })

        (stdenvNoCC.mkDerivation {
          name = "fluent-system-icons";
          src = "${fontPath}/fluent-system-icons.ttf";
          dontUnpack = true;
          installPhase = install "fluent-system-icons.ttf";
        })

        (stdenvNoCC.mkDerivation {
          name = "tabler-icons";
          src = "${fontPath}/tabler-icons.ttf";
          dontUnpack = true;
          installPhase = install "tabler-icons.ttf";
        })
      ]

      ++ optionals (_class == "nixos") [
        (stdenvNoCC.mkDerivation {
          name = "pixelon";
          src = "${fontPath}/pixelon.regular.ttf";
          dontUnpack = true;
          installPhase = install "pixelon.regular.ttf";
        })
      ];
  };
}
