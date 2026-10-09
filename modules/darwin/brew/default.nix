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
        tag = "7.0.8";
        hash = "sha256-ktO8OiPLPqaDMyJXi71XM19YX2oByqwopg5AA4AFn7g=";
      };

      mutableTaps = false;
      user = config.pixel.system.mainUser;

      # `nix-prefetch-github homebrew homebrew-core --nix`
      taps = {
        "homebrew/homebrew-core" = pkgs.fetchFromGitHub {
          owner = "homebrew";
          repo = "homebrew-core";
          rev = "c9f01628150078c996001ff0a99aeedd5f715f52";
          hash = "sha256-1/5JIUR/FoifPUieCyzFKHKFuZY1/W39QlFl89Wlz5s=";
        };

        "homebrew/homebrew-cask" = pkgs.fetchFromGitHub {
          owner = "homebrew";
          repo = "homebrew-cask";
          rev = "b7463efd8581af66eb577059ca5344267770012d";
          hash = "sha256-hpFYF1Kb61rxEjDgymdvfsywTRPdlXzJLVAgioEsoEY=";
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
        # "home-assistant"
        # "intellij-idea"
        # "notion"
        "whatsapp"
      ];
    };
  };
}
