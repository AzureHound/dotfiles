{ pkgs, ... }:

{
  plugins.grug-far = {
    enable = true;
    settings = {
      headerMaxWidth = 80;
      transient = true;
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>sr";
      action.__raw = ''
        function()
          require("grug-far").open({
            prefills = {
              paths = vim.fn.expand("%"),
            },
          })
        end
      '';
      options.desc = "Search and Replace (Current File)";
    }
    {
      mode = "x";
      key = "<leader>sr";
      action.__raw = ''
        function()
          require("grug-far").with_visual_selection({
            prefills = {
              paths = vim.fn.expand("%"),
            },
          })
        end
      '';
      options.desc = "Search and Replace (Selection)";
    }
    {
      mode = "n";
      key = "<leader>sw";
      action.__raw = ''
        function()
          require("grug-far").open({
            prefills = {
              search = vim.fn.expand("<cword>"),
              paths = vim.fn.expand("%"),
            },
          })
        end
      '';
      options.desc = "Search Current Word";
    }
  ];

  extraPackages = with pkgs; [
    ast-grep
    ripgrep
  ];
}
