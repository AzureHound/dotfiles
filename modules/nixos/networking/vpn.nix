{ pkgs, config, ... }:

{
  services.mullvad-vpn = {
    inherit (config.pixel.profiles.graphical) enable;

    package = pkgs.mullvad-vpn;

    enableExcludeWrapper = false;
  };
}
