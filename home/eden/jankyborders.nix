{ config, ... }:

{
  services.jankyborders = {
    enable = config.programs.aerospace.enable;

    settings = {
      style = "round";
      width = 5.0;
      hidpi = true;
      active_color = "0xffb7bdf8";
      inactive_color = "0x90cad3f5";
    };
  };
}
