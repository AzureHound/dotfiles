{ config, pkgs, ... }:

{
  programs.w3m = {
    inherit (config.pixel.profiles.workstation) enable;

    extraPackages = with pkgs; [ libsixel ];

    bookmarks = {
      marks = {
        nix = [
          {
            name = "nixos manual";
            url = "https://nixos.org/manual/nixos/stable/";
          }
          {
            name = "home-manager manual";
            url = "https://nix-community.github.io/home-manager/";
          }
        ];
      };
    };
  };
}
