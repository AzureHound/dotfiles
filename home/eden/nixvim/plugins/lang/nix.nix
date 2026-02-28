{ pkgs, ... }:

{
  plugins = {
    lsp.servers.nixd = {
      enable = true;
      settings = {
        formatting.command = [ "nixfmt" ];
        nixpkgs.expr = "import (builtins.getFlake (toString ./.)).inputs.nixpkgs { }";
        options = {
          nixos = {
            expr = "(builtins.getFlake (toString ./.)).nixosConfigurations.Orion.options";
          };
          nix-darwin = {
            expr = "(builtins.getFlake (toString ./.)).darwinConfigurations.Newton.options";
          };
          home-manager = {
            expr = "(builtins.getFlake (toString ./.)).nixosConfigurations.Orion.options.home-manager.users.type.getSubOptions []";
          };
        };
      };
    };

    conform-nvim.settings = {
      formatters_by_ft.nix = [ "nixfmt" ];
      formatters.nixfmt = {
        command = "nixfmt";
        args = [
          "--width"
          "120"
        ];
      };
    };

    treesitter.grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [ nix ];
  };

  extraPackages = with pkgs; [ nixfmt ];
}
