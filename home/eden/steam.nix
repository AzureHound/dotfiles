{
  lib,
  pkgs,
  inputs,
  ...
}:

{
  imports = [ inputs.millennium.homeManagerModules.default ];

  programs.steam = lib.mkIf pkgs.stdenv.hostPlatform.isLinux {
    theme = pkgs.millenniumThemes.adwaita;
    millenniumConfig = {
      themes.conditions."adwaita-for-steam" = {
        "Color theme" = "catppuccin-macchiato";
        "Hide What's New shelf" = "yes";
      };
    };

    # plugins = with pkgs.millenniumPlugins; [ global-launch-options ];
  };
}
