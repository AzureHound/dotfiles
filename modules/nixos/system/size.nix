{ lib, ... }:

let
  inherit (lib.modules) mkForce;
in

{
  environment = {
    stub-ld.enable = false;

    defaultPackages = mkForce [ ];
  };

  programs = {
    command-not-found.enable = false;
    less.enable = mkForce false;
    nano.enable = false;
  };

  fonts.fontDir.decompressFonts = true;

  services.speechd.enable = false;
}
