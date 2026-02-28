{ pkgs, ... }:

{
  plugins = {
    lsp.servers.texlab = {
      enable = true;
      settings.texlab = {
        build.onSave = true;
        forwardSearch.executable = "zathura";
        chktex.onOpenAndSave = true;
      };
    };
    lint.lintersByFt.tex = [ "chktex" ];
    treesitter.grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [ latex ];
  };

  extraPackages = with pkgs; [ texlab ];
}
