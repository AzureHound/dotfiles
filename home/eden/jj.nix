{ config, ... }:

let
  gitcfg = config.programs.git;
in

{
  programs = {
    jujutsu = {
      inherit (config.programs.git) enable;

      settings = {
        user = {
          inherit (gitcfg.settings.user) name email;
        };

        ui = {
          default-command = "status";
        };

        template-aliases = {
          "format_short_signature(signature)" = "signature.email().local()";
        };
      };
    };

    jjui = {
      inherit (config.programs.jujutsu) enable;

      settings = {
        ui = {
          colors = {
            "selected" = {
              bg = "#363a4f";
              fg = "#cad3f5";
              bold = true;
            };
            "shortcut" = {
              fg = "#c6a0f6";
            };
            "status" = {
              bg = "#24273a";
            };
            "status title" = {
              fg = "#cad3f5";
              bg = "#181926";
              bold = true;
            };
            "status shortcut" = {
              fg = "#c6a0f6";
            };
            "menu shortcut" = {
              fg = "#c6a0f6";
            };
          };
        };
      };
    };
  };
}
