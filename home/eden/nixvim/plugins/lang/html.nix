{ pkgs, ... }:

{
  plugins = {
    lsp.servers.html.enable = true;
    conform-nvim.settings.formatters_by_ft.html = [ "prettierd" ];
    treesitter.grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [ html ];
  };
}
