{ pkgs, ... }:

let
  maximizer-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "maximizer-nvim";
    src = pkgs.fetchFromGitHub {
      owner = "mthnglac";
      repo = "maximizer.nvim";
      rev = "9715e9678d8d5f3e27b32d9cfe1ab750bccd1cb2";
      sha256 = "1cip94k53b8ls86n6v6f5c3vnywqka9nhvswcx3jfaqp0k3nvsvc";
    };
  };
in

{
  extraPlugins = [ maximizer-nvim ];

  plugins.lz-n.plugins = [
    {
      __unkeyed-1 = "maximizer-nvim";
      cmd = [ "MaximizeToggle" ];
      after.__raw = "function() require('maximizer').setup({}) end";
    }
  ];
}
