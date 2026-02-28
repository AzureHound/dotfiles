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
  config = mkIf config.pixel.profiles.workstation.enable {
    home.packages = with pkgs; [ glow ];

    xdg.configFile."glow/glow.yml".text = ''
      style: "${config.catppuccin.sources.glamour}/catppuccin-${config.catppuccin.glamour.flavor}.json"
      local: true
      mouse: true
      pager: true
      width: 120
      all: true
    '';
  };
}
