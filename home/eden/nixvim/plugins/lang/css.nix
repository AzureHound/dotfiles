{ pkgs, ... }:

{
  plugins = {
    lsp.servers.cssls.enable = true;
    conform-nvim.settings.formatters_by_ft = {
      css = [ "prettierd" ];
      scss = [ "prettierd" ];
    };
    treesitter.grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      css
      scss
    ];
  };
}
