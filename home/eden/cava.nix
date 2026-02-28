{ config, ... }:

{
  programs.cava = {
    inherit (config.programs.rmpc) enable;

    settings = {
      general = {
        framerate = 30;
        sensitivity = 60;
        bars = 0;
        bar_width = 1;
        bar_spacing = 1;
      };

      input = {
        method = "pipewire";
        source = "auto";
      };

      output.orientation = "horizontal";

      smoothing = {
        monstercat = 0;
        waves = 1;
        noise_reduction = 30;
      };

      # Tokyo Night Theme
      color = {
        gradient = 1;
        gradient_count = 6;
        gradient_color_1 = "'#3d59a1'";
        gradient_color_2 = "'#7aa2f7'";
        gradient_color_3 = "'#bb9af7'";
        gradient_color_4 = "'#ff757f'";
        gradient_color_5 = "'#ffc777'";
        gradient_color_6 = "'#c53b53'";
      };
    };
  };

  # Theme
  catppuccin.cava.enable = false;
}
