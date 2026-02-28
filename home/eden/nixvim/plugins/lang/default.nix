{ pkgs, ... }:

{
  imports = [
    ./css.nix
    ./docker.nix
    # ./elixir.nix
    ./fish.nix
    ./git.nix
    ./html.nix
    # ./javascript.nix
    ./json.nix
    ./latex.nix
    ./lua.nix
    ./markdown.nix
    ./nix.nix
    ./nushell.nix
    # ./python.nix
    ./shell.nix
    # ./sql.nix
    # ./svelte.nix
    ./tailwind.nix
    ./toml.nix
    # ./typst.nix
    # ./vue.nix
    ./yaml.nix
  ];

  plugins.treesitter.grammarPackages =
    (with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      c
      http
      printf
      query
      rasi
      regex
      vim
      vimdoc
      xml
    ])
    ++ [
      pkgs.tree-sitter-grammars.tree-sitter-norg
    ];

  filetype = {
    extension = {
      rasi = "rasi";
      rofi = "rasi";
      wofi = "rasi";
    };
    pattern = {
      ".*/mako/config" = "dosini";
      ".*/waybar/config" = "jsonc";
    };
  };
}
