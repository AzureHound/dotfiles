{ pkgs, ... }:

{
  plugins = {
    lsp.servers.dockerls.enable = true;
    lint.lintersByFt.dockerfile = [ "hadolint" ];
    treesitter.grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [ dockerfile ];
  };

  extraPackages = with pkgs; [ hadolint ];
}
