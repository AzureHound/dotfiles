{
  lib,
  pkgs,
  config,
  ...
}:

let
  inherit (lib.modules) mkIf;

  inherit (config.pixel.programs) defaults;
in

{
  config = mkIf config.pixel.profiles.workstation.enable {
    programs.bat = {
      enable = true;

      config = {
        inherit (defaults) pager;
        paging = "always";
        italic-text = "always";
        map-syntax = [
          "*.ino:C++"
          ".ignore:Git Ignore"
        ];
      };

      extraPackages = with pkgs; [ bat-extras.core ];
    };

    home = {
      sessionVariables = {
        BATDIFF_USE_DELTA = true;
        BATPIPE_ENABLE_COLOR = true;
      };

      shellAliases = {
        cat = "bat -pp";
      };
    };
  };
}
