{
  pkgs,
  name,
  inputs,
  ...
}:

{
  imports = [
    inputs.disko.nixosModules.disko
    inputs.nixos-raspberrypi.nixosModules.raspberry-pi-5.base
    inputs.nixos-raspberrypi.nixosModules.raspberry-pi-5.bluetooth
    inputs.nixos-raspberrypi.nixosModules.raspberry-pi-5.page-size-16k
    inputs.nixos-raspberrypi.nixosModules.usb-gadget-ethernet

    ./disko.nix
    ./hardware.nix
  ];

  boot.loader.raspberry-pi.bootloader = "kernel";

  home-manager.users.${name} = import ./home.nix;

  pixel = {
    profiles = {
      headless.enable = true;
      server.enable = true;
    };

    system = {
      boot = {
        loader = "none";
        silent = true;
      };
      networking.tailscale = {
        enable = true;
        mode = "server";
      };
      bluetooth.enable = true;
    };
  };

  environment.systemPackages = with pkgs; [
    libraspberrypi
    raspberrypi-eeprom
  ];

  services.openthread-border-router.backboneInterfaces = [ "eth0" ];
}
