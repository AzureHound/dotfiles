{
  lib,
  pkgs,
  config,
  inputs,
  ...
}:

let
  inherit (lib.modules) mkIf;
in

{
  imports = [ inputs.pi-catppuccin.homeManagerModules.default ];

  config = mkIf config.pixel.profiles.graphical.enable {
    programs = {
      pi-coding-agent = {
        enable = true;

        settings = {
          defaultProvider = "ollama";
          defaultModel = "gemma4:12b";
          theme = "catppuccin-macchiato";
        };

        models = {
          providers = {
            ollama = {
              baseUrl = "http://localhost:11434/v1";
              api = "openai-completions";
              apiKey = "ollama";
              models = [
                { id = "gemma4:12b"; }
              ];
            };
          };
        };

        extraPackages = with pkgs; [
          bun
          nodejs
        ];
      };

      pi.catppuccin = {
        enable = true;
        flavor = "macchiato";
      };
    };

    home.activation = {
      setPiTheme = lib.mkForce "";
    };
  };
}
