{
  nix = {
    channel.enable = false;

    settings = {
      experimental-features = [
        "flakes"
        "nix-command"
      ];

      log-lines = 50;
      warn-dirty = false;
      http-connections = 50;
      flake-registry = "";
      accept-flake-config = false;
      auto-optimise-store = false;

      substituters = [
        "https://nix-community.cachix.org"
        "https://cache.nixos.org"
        "https://catppuccin.cachix.org"
      ];

      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "catppuccin.cachix.org-1:noG/4HkbhJb+lUAdKrph6LaozJvAeEEZj4N732IysmU="
      ];
    };
  };
}
