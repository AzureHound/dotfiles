{
  _class = "nixos";

  imports = [
    ../core
    ./boot
    ./containers
    ./docker.nix
    ./emulation.nix
    ./env
    ./gaming.nix
    ./hardware
    ./home.nix
    ./headless.nix
    ./kernel
    ./networking
    ./nix.nix
    ./programs
    ./secrets.nix
    ./security
    ./services
    ./system
    ./theme.nix
    ./users
    ./virt.nix
    ./windows.nix
  ];
}
