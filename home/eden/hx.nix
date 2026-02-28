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
  config = mkIf config.pixel.profiles.development.enable {
    programs.helix = {
      enable = true;

      settings = {
        editor = {
          scrolloff = 10;
          shell = [
            "zsh"
            "-c"
          ];
          line-number = "relative";
          cursorline = true;
          continue-comments = false;
          bufferline = "multiple";
          color-modes = true;
          insert-final-newline = false;
          trim-final-newlines = true;
          trim-trailing-whitespace = true;
          popup-border = "all";
          end-of-line-diagnostics = "hint";

          lsp = {
            display-inlay-hints = true;
          };

          cursor-shape = {
            insert = "bar";
            select = "underline";
          };

          file-picker = {
            hidden = false;
          };

          indent-guides = {
            render = true;
            # skip-levels = 1;
          };

          inline-diagnostics = {
            cursor-line = "warning";
          };
        };
      };

      languages = {
        language = [
          {
            name = "nix";
            auto-format = true;
            formatter = {
              command = "nixfmt";
            };
          }
        ];
      };
    };

    xdg.desktopEntries = mkIf pkgs.stdenv.hostPlatform.isLinux {
      Helix = {
        name = "Helix";
        noDisplay = true;
      };
    };
  };
}
