{
  lib,
  pkgs,
  config,
  inputs,
  ...
}:

let
  inherit (lib.modules) mkIf;
  inherit (lib.options) mkEnableOption;

  sys = config.pixel.system.boot;
in

{
  # https://wiki.nixos.org/wiki/Secure_Boot
  imports = [ inputs.lanzaboote.nixosModules.lanzaboote ];

  options.pixel.system.boot.secureBoot = mkEnableOption "secure-boot & load pkgs";

  config = mkIf sys.secureBoot {
    boot = {
      lanzaboote = {
        enable = true;
        pkiBundle = "/var/lib/sbctl";
      };
    };

    environment.systemPackages = with pkgs; [ sbctl ];
  };
}
