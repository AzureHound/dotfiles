{ pkgs, ... }:

{
  autoCmd = [
    {
      event = [
        "BufRead"
        "BufNewFile"
      ];
      pattern = [ "*git/config" ];
      command = "set filetype=gitconfig";
    }
  ];

  plugins.treesitter.grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
    diff
    git_config
    gitignore
  ];

  extraConfigLua = ''
    vim.treesitter.language.register('git_config', 'gitconfig')
  '';
}
