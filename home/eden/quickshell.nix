{
  lib,
  pkgs,
  config,
  ...
}:

let
  inherit (lib.modules) mkIf;
in

{
  config = mkIf config.programs.quickshell.enable {
    programs.quickshell = {
      package = pkgs.symlinkJoin {
        name = "quickshell-wrapped";
        paths = [
          pkgs.quickshell
          pkgs.kdePackages.qtimageformats
          pkgs.adwaita-icon-theme
        ];
        meta.mainProgram = pkgs.quickshell.meta.mainProgram;
      };

      systemd.enable = true;
    };
  };
}
