{ config, ... }:

{
  programs.hyprshot = {
    enable = config.programs.hyprland.enable;

    saveLocation = "~/Pictures/screenshots";
  };
}
