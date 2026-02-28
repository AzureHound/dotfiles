{ pkgs, config, ... }:

{
  services.udiskie = {
    enable = config.pixel.profiles.graphical.enable && pkgs.stdenv.hostPlatform.isLinux;

    tray = "never";
    automount = true;
    notify = true;
  };
}
