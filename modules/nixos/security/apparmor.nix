{ pkgs, ... }:

{
  services.dbus.apparmor = "disabled";

  security.apparmor = {
    enable = true;

    enableCache = true; # /var/cache/apparmor
    killUnconfinedConfinables = true;
    packages = with pkgs; [ apparmor-profiles ];
  };
}
