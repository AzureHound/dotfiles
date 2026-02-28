{ pkgs, ... }:

{
  plugins = {
    lsp.servers.nushell.enable = true;
    conform-nvim.settings.formatters_by_ft.nu = [ "nufmt" ];
    treesitter.grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [ nu ];
  };

  extraPackages = with pkgs; [
    nushell
    nufmt
  ];
}
