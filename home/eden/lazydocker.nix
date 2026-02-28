{ lib, osConfig, ... }:

let
  inherit (lib.modules) mkIf;
in

{
  config = mkIf ((osConfig.pixel ? services) && osConfig.pixel.services.docker.enable) {
    programs.lazydocker = {
      enable = true;

      # https://github.com/jesseduffield/lazydocker/blob/master/docs/Config.md#default
      settings = {
        gui = {
          theme = {
            activeBorderColor = [ "#a6da95" ];
            inactiveBorderColor = [ "#a5adcb" ];
            # selectedLineBgColor = [ "#363a4f" ];
            optionsTextColor = [ "#8aadf4" ];
          };
          sidePanelWidth = 0.25;
          showBottomLine = false;
          expandFocusedSidePanel = true;
        };

        os = {
          openCommand = "$EDITOR {{filename}}";
          openLinkCommand = "xdg-open {{link}}";
        };
      };
    };

    home.shellAliases = {
      ld = "lazydocker";
    };
  };
}
