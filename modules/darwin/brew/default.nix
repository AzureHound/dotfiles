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
        tag = "7.0.11";
        hash = "sha256-8mCor0DDjNhi+0e+FllfqiMABujBl+/RxYW+wgMpcto=";
      };

      mutableTaps = false;
      user = config.pixel.system.mainUser;

      # `nix-prefetch-github homebrew homebrew-core --nix`
      taps = {
        "homebrew/homebrew-core" = pkgs.fetchFromGitHub {
          owner = "homebrew";
          repo = "homebrew-core";
          rev = "44447c5cdba6a67ce116e4f78bab29b4c69312d7";
          hash = "sha256-Sef2RSF9s24ID91htwuAVGsZZwA+kroBRM77qbbRzT0=";
        };

        "homebrew/homebrew-cask" = pkgs.fetchFromGitHub {
          owner = "homebrew";
          repo = "homebrew-cask";
          rev = "e9707c29ee761b7190f73cc79e56e1033b685cbc";
          hash = "sha256-4zrPeeSgvWGrsZXHtmgEhtR63bi2YWMDk7cu6XlofLI=";
        };

        # "abue-ammar/homebrew-tinycast" = pkgs.fetchFromGitHub {
        #   owner = "abue-ammar";
        #   repo = "homebrew-tinycast";
        #   rev = "16a510a98e61b3ff882844c57f5656386735fa8d";
        #   hash = "sha256-2e24I9zGYRK++ff2wBcj11u7KbapzOYYbI/KRpRMsfc=";
        # };
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
        # "abue-ammar/tinycast/tinycast"

        "ghostty"
        # "home-assistant"
        # "intellij-idea"
        # "notion"
        "whatsapp"
      ];
    };
  };
}
