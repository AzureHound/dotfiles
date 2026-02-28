{ pkgs, ... }:

{
  plugins = {
    lsp.servers.sqls.enable = true;
    treesitter.grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [ sql ];
  };
}
