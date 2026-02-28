{ pkgs, ... }:

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
}
