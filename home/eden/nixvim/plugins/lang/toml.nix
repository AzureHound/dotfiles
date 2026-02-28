{ pkgs, ... }:

{
  plugins = {
    lsp.servers.taplo.enable = true;
    conform-nvim.settings.formatters_by_ft.toml = [ "taplo" ];
    treesitter.grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [ toml ];
  };

  extraPackages = with pkgs; [ taplo ];
}
