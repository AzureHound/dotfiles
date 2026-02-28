{ pkgs, ... }:

{
  plugins = {
    lsp.servers.svelte.enable = true;
    conform-nvim.settings.formatters_by_ft.svelte = [ "prettierd" ];
    treesitter.grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [ svelte ];
  };
}
