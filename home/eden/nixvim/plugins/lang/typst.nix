{ pkgs, ... }:

{
  plugins = {
    lsp.servers.tinymist = {
      enable = true;
      settings = {
        exportPdf = "onType";
        formatterMode = "typstyle";
      };
    };
    conform-nvim.settings.formatters_by_ft.typst = [ "typstyle" ];
    treesitter.grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [ typst ];
  };

  extraPackages = with pkgs; [
    tinymist
    typstyle
  ];
}
