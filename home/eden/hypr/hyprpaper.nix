{ config, ... }:

{
  services.hyprpaper = {
    enable = config.programs.hyprland.enable;

    settings = {
      # █ █ █▄█ █▀█ █▀█ █▀█ ▄▀█ █▀█ █▀▀ █▀█
      # █▀█  █  █▀▀ █▀▄ █▀▀ █▀█ █▀▀ ██▄ █▀▄

      wallpaper = [
        {
          monitor = "";
          path = "~/Developer/Wallpapers/glass-red-abstract.png";
          fit_mode = "cover";
        }
      ];

      ipc = "on";
      splash = false;
    };
  };
}
