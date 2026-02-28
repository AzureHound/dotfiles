{
  plugins.bufferline = {
    enable = true;
    lazyLoad.settings.event = [
      "BufAdd"
      "BufDelete"
    ];

    settings = {
      highlights.__raw = ''
        require("catppuccin.special.bufferline").get_theme()
      '';

      options = {
        themable = true;
        diagnostics = "nvim_lsp";
        always_show_bufferline = false;
        hover = {
          enabled = true;
          delay = 200;
          reveal = [ "close" ];
        };
        offsets = [
          {
            filetype = "snacks_explorer";
            text = "Explorer";
            highlight = "Directory";
            text_align = "right";
          }
          {
            filetype = "snacks_layout_box";
          }
        ];
      };
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>bp";
      action = "<Cmd>BufferLineTogglePin<CR>";
      options.desc = "Toggle Pin";
    }
    {
      mode = "n";
      key = "<leader>bP";
      action = "<Cmd>BufferLineGroupClose ungrouped<CR>";
      options.desc = "Delete Non-Pinned Buffers";
    }
    {
      mode = "n";
      key = "<leader>br";
      action = "<Cmd>BufferLineCloseRight<CR>";
      options.desc = "Delete Buffers to the Right";
    }
    {
      mode = "n";
      key = "<leader>bl";
      action = "<Cmd>BufferLineCloseLeft<CR>";
      options.desc = "Delete Buffers to the Left";
    }
    {
      mode = "n";
      key = "<S-h>";
      action = "<cmd>BufferLineCyclePrev<cr>";
      options.desc = "Prev Buffer";
    }
    {
      mode = "n";
      key = "<S-l>";
      action = "<cmd>BufferLineCycleNext<cr>";
      options.desc = "Next Buffer";
    }
    {
      mode = "n";
      key = "[b";
      action = "<cmd>BufferLineCyclePrev<cr>";
      options.desc = "Prev Buffer";
    }
    {
      mode = "n";
      key = "]b";
      action = "<cmd>BufferLineCycleNext<cr>";
      options.desc = "Next Buffer";
    }
    {
      mode = "n";
      key = "[B";
      action = "<cmd>BufferLineMovePrev<cr>";
      options.desc = "Move buffer prev";
    }
    {
      mode = "n";
      key = "]B";
      action = "<cmd>BufferLineMoveNext<cr>";
      options.desc = "Move buffer next";
    }
    {
      mode = "n";
      key = "<leader>bj";
      action = "<cmd>BufferLinePick<cr>";
      options.desc = "Pick Buffer";
    }
  ];

  opts.mousemoveevent = true;
}
