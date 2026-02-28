{
  lib,
  pkgs,
  config,
  inputs,
  ...
}:

let
  inherit (lib.modules) mkIf;
in

{
  imports = [ inputs.nixvim.homeModules.nixvim ];

  programs.nixvim = {
    inherit (config.pixel.profiles.workstation) enable;

    nixpkgs.source = pkgs.path;

    imports = [
      ./core
      ./plugins
    ];
  };

  xdg.desktopEntries = mkIf pkgs.stdenv.hostPlatform.isLinux {
    nvim = {
      name = "Neovim wrapper";
      noDisplay = true;
    };
  };
}
