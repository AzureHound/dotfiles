{ lib, config, ... }:

let
  inherit (lib.modules) mkIf;
in

{
  config = mkIf config.pixel.profiles.workstation.enable {
    programs.ripgrep = {
      enable = true;

      # https://github.com/BurntSushi/ripgrep/blob/master/GUIDE.md#configuration-file
      arguments = [
        "--glob=!.git/*"
        "--glob=!vendor/*"
        "--max-columns=150"
        "--max-columns-preview"
        "--smart-case"
      ];
    };

    home.shellAliases = {
      rg = "rg -i";
    };
  };
}
