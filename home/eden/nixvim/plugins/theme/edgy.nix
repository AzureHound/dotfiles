{
  plugins.edgy = {
    enable = true;

    settings = {
      # Panels
      bottom = [
        {
          __raw = ''
            {
              ft = "toggleterm",
              size = { height = 0.4 },
              filter = function(_, win) return vim.api.nvim_win_get_config(win).relative == "" end
            }
          '';
        }
        {
          __raw = ''
            {
              ft = "noice",
              size = { height = 0.4 },
              filter = function(_, win) return vim.api.nvim_win_get_config(win).relative == "" end
            }
          '';
        }
        {
          ft = "trouble";
          title = "Trouble";
        }
        {
          ft = "qf";
          title = "QuickFix";
        }
        {
          ft = "help";
          size = 20;
          filter.__raw = "function(buf) return vim.bo[buf].buflisted and vim.bo[buf].buftype == 'help' end";
        }
        {
          ft = "neotest-output-panel";
          title = "Neotest Output";
          size = 15;
        }
      ];

      left = [
        {
          ft = "neo-tree";
          title = "Neo-Tree Filesystem";
          filter.__raw = "function(buf) return vim.b[buf].neo_tree_source == 'filesystem' end";
          pinned = true;
        }
        {
          ft = "neotest-summary";
          title = "Neotest Summary";
        }
      ];

      right = [
        { __raw = "{ ft = 'grug-far', title = 'Grug Far', size = { width = 0.4 } }"; }
        {
          ft = "neo-tree";
          title = "Neo-Tree Git";
          filter.__raw = "function(buf) return vim.b[buf].neo_tree_source == 'git_status' end";
          pinned = true;
        }
      ];

      keys = {
        "<c-Right>".__raw = "function(win) win:resize('width', 2) end";
        "<c-Left>".__raw = "function(win) win:resize('width', -2) end";
        "<c-Up>".__raw = "function(win) win:resize('height', 2) end";
        "<c-Down>".__raw = "function(win) win:resize('height', -2) end";
      };
    };
  };

  # Integrations
  plugins.telescope.settings.defaults.get_selection_window.__raw = ''
    function()
      require("edgy").goto_main()
      return 0
    end
  '';

  keymaps = [
    {
      mode = "n";
      key = "<leader>ue";
      action.__raw = "function() require('edgy').toggle() end";
      options.desc = "Edgy Toggle";
    }
    {
      mode = "n";
      key = "<leader>uE";
      action.__raw = "function() require('edgy').select() end";
      options.desc = "Edgy Select Window";
    }
  ];

  # Bufferline
  plugins.bufferline.settings.options.offsets = [
    {
      filetype = "snacks_explorer";
      text = "Explorer";
      highlight = "Directory";
      text_align = "right";
    }
  ];
}
