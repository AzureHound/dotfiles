{
  pkgs,
  config,
  inputs,
  ...
}:

{
  imports = [
    inputs.homebrew.darwinModules.nix-homebrew

    ./env.nix
  ];

  config = {
    nix-homebrew = {
      enable = true;

      package = pkgs.fetchFromGitHub {
        owner = "homebrew";
        repo = "brew";
        tag = "7.0.0";
        hash = "sha256-1uLAp0lNdt2blJOJ26jIwJbEwg8/ttc7XMpyxzXx3vI=";
      };

      mutableTaps = false;
      user = config.pixel.system.mainUser;

      # `nix-prefetch-github homebrew homebrew-core --nix`
      taps = {
        "homebrew/homebrew-core" = pkgs.fetchFromGitHub {
          owner = "homebrew";
          repo = "homebrew-core";
          rev = "b148af37ec51d1fad173909e1a07c0d2cf288ab8";
          hash = "sha256-bo+Lbr9xNyQIcDtOxwLKEENzdQ5ivS8jxPxpv4BRqvA=";
        };

        "homebrew/homebrew-cask" = pkgs.fetchFromGitHub {
          owner = "homebrew";
          repo = "homebrew-cask";
          rev = "c15c00e922d79de132cccbee770b9d4f5bac8a6d";
          hash = "sha256-2Cy9Qq+oKCp45hce5ZeI4MeTSxFcASMnmMK9sxfYaeU=";
        };
      };
    };

    # https://brew.sh
    homebrew = {
      enable = true;

      caskArgs.require_sha = true;
      global.autoUpdate = false;

      onActivation = {
        # autoUpdate = true; # should be managed by nix-homebrew
        upgrade = true;
        # 'zap': uninstalls all formulae [ & related files ] not listed here.
        cleanup = "zap";
      };

      # https://github.com/mas-cli/mas
      masApps = {
        "Encrypto" = 935235287;
        "iMovie" = 408981434;
        "Keynote" = 361285480;
        "Numbers" = 361304891;
        "Pages" = 361309726;
        "Xcode" = 497799835;
      };

      taps = builtins.attrNames config.nix-homebrew.taps;

      # `brew install`
      brews = [ "mole" ];

      # `brew install --cask`
      casks = [
        "ghostty"
        # "intellij-idea"
        # "notion"
        "whatsapp"
      ];
    };
  };
}
