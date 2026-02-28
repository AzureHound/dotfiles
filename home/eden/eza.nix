{ config, ... }:

{
  programs.eza = {
    inherit (config.pixel.profiles.workstation) enable;

    icons = "auto";

    extraOptions = [
      # "--group"
      # "--group-directories-first"
      # "--header"
      # "--no-permissions"
      # "--octal-permissions"
    ];
  };
}
