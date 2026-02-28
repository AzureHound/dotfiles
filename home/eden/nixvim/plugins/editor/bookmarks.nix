{ pkgs, ... }:

let
  bookmarks-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "bookmarks-nvim";
    src = pkgs.fetchFromGitHub {
      owner = "tomasky";
      repo = "bookmarks.nvim";
      rev = "e502d33bf87a6b16b7e590a2896e87d3f9203d27";
      sha256 = "0983274f0ysb5r7p0p62kxf1x7bcnzvjzy9pa8wkvyv9fjl77qrk";
    };
  };
in

{
  extraPlugins = [ bookmarks-nvim ];

  extraConfigLua = ''
    require("bookmarks").setup({
      save_file = vim.fn.stdpath("state") .. "/bookmarks",
      keywords = {
        ["@t"] = "󰄵 ",
        ["@w"] = " ",
        ["@f"] = " ",
        ["@n"] = " ",
      },
    })

    require("telescope").load_extension("bookmarks")
  '';

  keymaps = [
    {
      mode = "n";
      key = "<leader>fB";
      action = "<cmd>Telescope bookmarks list<cr>";
      options.desc = "Bookmarks (Telescope)";
    }
    {
      mode = "n";
      key = "mm";
      action.__raw = "function() require('bookmarks').bookmark_toggle() end";
      options.desc = "Toggle Bookmark";
    }
    {
      mode = "n";
      key = "ml";
      action.__raw = "function() require('bookmarks').bookmark_ann() end";
      options.desc = "Add/Edit Annotation";
    }
    {
      mode = "n";
      key = "mc";
      action.__raw = "function() require('bookmarks').bookmark_clean() end";
      options.desc = "Clean Marks in Buffer";
    }
    {
      mode = "n";
      key = "mx";
      action.__raw = "function() require('bookmarks').bookmark_clear_all() end";
      options.desc = "Remove ALL Bookmarks";
    }
    {
      mode = "n";
      key = "mn";
      action.__raw = "function() require('bookmarks').bookmark_next() end";
      options.desc = "Next Bookmark";
    }
    {
      mode = "n";
      key = "mp";
      action.__raw = "function() require('bookmarks').bookmark_prev() end";
      options.desc = "Previous Bookmark";
    }
    {
      mode = "n";
      key = "]k";
      action.__raw = "function() require('bookmarks').bookmark_next() end";
      options.desc = "Next Bookmark";
    }
    {
      mode = "n";
      key = "[k";
      action.__raw = "function() require('bookmarks').bookmark_prev() end";
      options.desc = "Previous Bookmark";
    }
    {
      mode = "n";
      key = "mL";
      action.__raw = "function() require('bookmarks').bookmark_list() end";
      options.desc = "List Bookmarks (Quickfix)";
    }
  ];
}
