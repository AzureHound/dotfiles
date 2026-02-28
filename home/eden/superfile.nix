{ config, ... }:

{
  programs.superfile = {
    inherit (config.pixel.profiles.graphical) enable;

    firstUseCheck = false;

    settings = {
      ignore_missing_fields = true;
      theme = "catppuccin-macchiato";
      transparent_background = true;
      metadata = true;
      zoxide_support = true;
    };

    pinnedFolders = [
      {
        name = "Developer";
        location = "${config.home.homeDirectory}/Developer";
      }
      {
        name = "Downloads";
        location = "${config.home.homeDirectory}/Downloads";
      }
      {
        name = "Documents";
        location = "${config.home.homeDirectory}/Documents";
      }
    ];
  };
}
