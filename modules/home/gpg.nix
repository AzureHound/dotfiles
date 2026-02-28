{ config, ... }:

{
  programs.gpg = {
    inherit (config.pixel.profiles.workstation) enable;

    homedir = "${config.xdg.dataHome}/gnupg";

    settings = {
      no-greeting = true;
    };
  };
}
