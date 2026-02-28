{ lib, osConfig, ... }:

let
  inherit (lib.modules) mkDefault;
in

{
  programs.home-manager.enable = true;

  home.stateVersion = osConfig.pixel.system.stateVersion;

  systemd.user.startServices = mkDefault "sd-switch"; # NOTE: "legacy" if "sd-switch" breaks
}
