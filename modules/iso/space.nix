{ lib, ... }:

let
  inherit (lib.modules) mkForce;
in

{
  documentation = {
    enable = mkForce false;
    dev.enable = mkForce false;
    doc.enable = mkForce false;
    info.enable = mkForce false;
    nixos.enable = mkForce false;

    man = {
      enable = false;
      man-db.enable = false;
    };
  };

  environment.defaultPackages = mkForce [ ];

  programs.less.enable = mkForce false;

  # rm perl
  services.userborn.enable = true;

  system = {
    etc.overlay = {
      enable = true;
      mutable = false;
    };

    extraDependencies = mkForce [ ];

    installer.channel.enable = false;
  };
}
