{
  lib,
  pkgs,
  config,
  ...
}:

let
  inherit (lib.modules) mkIf mkForce;
in

{
  config = mkIf config.pixel.profiles.graphical.enable {
    boot.plymouth = {
      enable = true;

      theme = "catppuccin-macchiato";
      themePackages = mkForce [
        (pkgs.catppuccin-plymouth.override {
          variant = "macchiato";
        })
      ];
      # theme = "nixos-bgrt";
      # themePackages = [
      #   pkgs.nixos-bgrt-plymouth
      # ];
      font = "${pkgs.nerd-fonts.jetbrains-mono}/share/fonts/truetype/NerdFonts/JetBrainsMono/JetBrainsMonoNerdFont-Regular.ttf";
    };
  };
}
