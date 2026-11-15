{ lib, pkgs, ... }:

{
  system = {
    disableInstallerTools = true;

    tools = {
      nixos-enter.enable = true;
      nixos-install.enable = true;

      nixos-rebuild = {
        enable = true;
        enableRun0Elevation = true;
      };
    };
  };

  programs.git.package = pkgs.gitMinimal;

  # https://github.com/NixOS/nixpkgs/blob/b75227dfa10fe49fd0cae2f5ef82e97babd16c44/nixos/modules/profiles/installation-device.nix#L136-L144
  nixpkgs.overlays = lib.modules.mkForce [ ];
}
