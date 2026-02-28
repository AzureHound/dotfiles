{ pkgs, ... }:

{
  plugins = {
    lsp.servers.volar.enable = true;
    treesitter.grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [ vue ];
  };
}
