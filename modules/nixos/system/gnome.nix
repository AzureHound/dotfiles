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
    services = {
      udev.packages = with pkgs; [ gnome-settings-daemon ];

      gnome = {
        glib-networking.enable = true;

        gnome-keyring.enable = true;

        # https://github.com/NixOS/nixpkgs/pull/379731
        gcr-ssh-agent.enable = false;

        gnome-remote-desktop.enable = mkForce false;
      };
    };
  };
}
