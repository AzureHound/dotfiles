{ pkgs, ... }:

{
  plugins = {
    lsp.servers.bashls.enable = true;
    conform-nvim.settings.formatters_by_ft = {
      bash = [
        "shellcheck"
        "shellharden"
        "shfmt"
      ];
      sh = [ "shfmt" ];
      zsh = [ "shfmt" ];
    };
    lint.lintersByFt.bash = [ "shellcheck" ];
    treesitter.grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [ bash ];
  };

  filetype.pattern."%.env%.[%w_.-]+" = "sh";

  extraPackages = with pkgs; [
    shfmt
    shellcheck
    shellharden
  ];
}
