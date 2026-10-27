{ config, ... }:

{
  programs.hyprtoolkit = {
    inherit (config.programs.hyprland) enable;

    settings = {
      background = "0xFF24273A";
      base = "0xFF1E2030";
      text = "0xFFCAD3F5";
      accent = "0xFF8AADF4";
    };
  };
}
