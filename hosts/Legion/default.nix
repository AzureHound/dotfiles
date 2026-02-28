{
  pkgs,
  name,
  inputs,
  ...
}:

{
  imports = [
    inputs.disko.nixosModules.disko
    inputs.nixos-hardware.nixosModules.raspberry-pi-5

    ./disko.nix
    ./hardware.nix
  ];

  hardware.raspberry-pi."5".apply-overlays-dtmerge.enable = true;

  home-manager.users.${name} = import ./home.nix;

  pixel = {
    profiles = {
      headless.enable = true;
      server.enable = true;
    };

    services = {
      docker.enable = true;
      forgejo.enable = true;
      homepage.enable = true;
      immich.enable = true;
      karakeep.enable = true;
      microbin.enable = true;
      navidrome.enable = true;
      nginx.enable = true;
      opencloud.enable = true;
      radicale.enable = true;
      samba.enable = true;
      search.enable = true;
      syncthing.enable = true;
      technitium.enable = true;
      vaultwarden.enable = true;

      # db
      postgresql.enable = true;
      redis.enable = true;

      # xservices
      pi.enable = true;
      truenas.enable = true;
    };

    system = {
      kernel.packages = pkgs.linuxPackagesFor (
        pkgs.callPackage "${inputs.nixos-hardware}/raspberry-pi/common/kernel.nix" {
          rpiVersion = 5;
        }
      );

      boot = {
        loader = "none";
        silent = true;
      };
      networking.tailscale = {
        enable = true;
        mode = "server";
      };
    };
  };

  environment.systemPackages = with pkgs; [
    libraspberrypi
    raspberrypi-eeprom
  ];
}
