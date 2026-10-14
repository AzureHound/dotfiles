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
        tag = "7.0.9";
        hash = "sha256-+7waf1/I5YZPPZOwGDGqhrw9k3lDdXhdk4nglsQcqyA=";
      };

      mutableTaps = false;
      user = config.pixel.system.mainUser;

      # `nix-prefetch-github homebrew homebrew-core --nix`
      taps = {
        "homebrew/homebrew-core" = pkgs.fetchFromGitHub {
          owner = "homebrew";
          repo = "homebrew-core";
          rev = "a0882cbbae13d9802a4472d836b328f8497834bf";
          hash = "sha256-pvHQwCCG4zAfN8RHzM7BygKHbzksAsl3cGNekmkdXVA=";
        };

        "homebrew/homebrew-cask" = pkgs.fetchFromGitHub {
          owner = "homebrew";
          repo = "homebrew-cask";
          rev = "d4d25dbd93eef9ed20f4ae73f3c269a728a412eb";
          hash = "sha256-FkuEIGWiCMhpV7OYfwJUkI7yrHI3AY70KrZ2KnF9hXI=";
        };

        # "abue-ammar/homebrew-tinycast" = pkgs.fetchFromGitHub {
        #   owner = "abue-ammar";
        #   repo = "homebrew-tinycast";
        #   rev = "3a9a0fa4de664a0aa2b34880e71626dd55309a38";
        #   hash = "sha256-GSG018gaRrzd0iycO3cM2rNPpamTXwt1Z5AlQG/kcZo=";
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
