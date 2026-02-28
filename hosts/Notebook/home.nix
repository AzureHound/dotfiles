{ pkgs, mkCfgLink, ... }:

{
  pixel = {
    profiles = {
      development.enable = true;
      # pentesting.enable = true;

      media = {
        # editing.enable = true;
        listening.enable = true;
        # streaming.enable = true;
        watching.enable = true;
      };
    };
  };

  programs = {
    # chromium.enable = true;
    firefox.enable = true;
    foot.enable = true;
    qutebrowser.enable = true;
    thunderbird.enable = true;
    zsh.enable = true;
  };

  services.mako.enable = true;

  home.packages = with pkgs; [
    brightnessctl
    foot
    simple-scan
    swaybg
  ];

  # configHome
  xdg.configFile = mkCfgLink [
    "sway"
    "swaylock"
  ];

  # ignore .desktop
  ign.desktop = [ "zen-beta.desktop" ];
}
