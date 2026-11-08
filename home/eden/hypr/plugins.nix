{
  lib,
  pkgs,
  config,
  ...
}:

let
  inherit (lib.modules) mkIf;

  hyprexpo = pkgs.callPackage (pkgs.fetchFromGitHub {
    owner = "sandwichfarm";
    repo = "hyprexpo";
    rev = "v0.57.1";
    hash = "sha256-scuBNOlg6AxrjMHdywZJGmsWGoCs330JgqqE2L0sQek=";
  }) { };
in

{
  config = mkIf config.programs.hyprland.enable {
    wayland.windowManager.hyprland = {
      plugins = [
        hyprexpo
        # pkgs.hyprlandPlugins.csgo-vulkan-fix
      ];
    };
  };
}