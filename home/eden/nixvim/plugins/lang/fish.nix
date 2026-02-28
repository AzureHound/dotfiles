{ pkgs, ... }:

{
  plugins = {
    lsp.servers.fish_lsp.enable = true;
    conform-nvim.settings.formatters_by_ft.fish = [ "fish_indent" ];
    lint.lintersByFt.fish = [ "fish" ];
    treesitter.grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [ fish ];
  };

  extraPackages = with pkgs; [ fish ];
}
