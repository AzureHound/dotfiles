{ pkgs, ... }:

let
  log-highlight-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "log-highlight-nvim";
    src = pkgs.fetchFromGitHub {
      owner = "fei6409";
      repo = "log-highlight.nvim";
      rev = "v1.2.1";
      sha256 = "16d571qf8jqmsry0ybp1kvax8sq6kqy7p8vb1xdz9ikrn5daincc";
    };
  };
in

{
  extraPlugins = [ log-highlight-nvim ];

  plugins.lz-n.plugins = [
    {
      __unkeyed-1 = "log-highlight-nvim";
      ft = [ "log" ];
      after.__raw = "function() require('log-highlight').setup({}) end";
    }
  ];
}
