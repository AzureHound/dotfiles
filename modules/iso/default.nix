# https://github.com/NixOS/nixpkgs/blob/90a153e81e7deb0b2ea1466c8a2f515df1974717/nixos/modules/profiles/installation-device.nix#L32

{ modulesPath, ... }:

{
  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-minimal-new-kernel.nix"

    ./boot.nix
    ./console.nix
    ./fixes.nix
    # ./ghost # TODO:
    ./img.nix
    ./networking.nix
    ./nix.nix
    ./nixpkgs.nix
    ./programs.nix
    ./security.nix
    ./space.nix
  ];
}
