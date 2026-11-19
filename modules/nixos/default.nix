{
  _class = "nixos";

  imports = [
    ../core
    ./boot
    ./containers
    ./emulation.nix
    ./env
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
  ];
}
