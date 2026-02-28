{
  plugins.gitsigns = {
    enable = true;
    lazyLoad.settings.event = "DeferredUIEnter";

    settings = {
      signs = {
        add = {
          text = "▎";
        };
        change = {
          text = "▎";
        };
        delete = {
          text = "";
        };
        topdelete = {
          text = "";
        };
        changedelete = {
          text = "▎";
        };
        untracked = {
          text = "▎";
        };
      };
      signs_staged = {
        add = {
          text = "▎";
        };
        change = {
          text = "▎";
        };
        delete = {
          text = "";
        };
        topdelete = {
          text = "";
        };
        changedelete = {
          text = "▎";
        };
      };
      current_line_blame = false;
      trouble = true;
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>uG";
      action.__raw = ''
        function()
          Snacks.toggle({
            name = "Git Signs",
            get = function()
              return require("gitsigns.config").config.signcolumn
            end,
            set = function(state)
              require("gitsigns").toggle_signs(state)
            end,
          }):map("<leader>uG")
        end
      '';
      options.desc = "Toggle Git Signs";
    }
    {
      mode = "n";
      key = "]h";
      action.__raw = ''
        function()
          if vim.wo.diff then
            vim.cmd.normal({ "]c", bang = true })
          else
            require("gitsigns").nav_hunk("next")
          end
        end
      '';
      options.desc = "Next Hunk";
    }
    {
      mode = "n";
      key = "[h";
      action.__raw = ''
        function()
          if vim.wo.diff then
            vim.cmd.normal({ "[c", bang = true })
          else
            require("gitsigns").nav_hunk("prev")
          end
        end
      '';
      options.desc = "Prev Hunk";
    }
    {
      mode = "n";
      key = "]H";
      action.__raw = "function() require('gitsigns').nav_hunk('last') end";
      options.desc = "Last Hunk";
    }
    {
      mode = "n";
      key = "[H";
      action.__raw = "function() require('gitsigns').nav_hunk('first') end";
      options.desc = "First Hunk";
    }
    {
      mode = [
        "n"
        "x"
      ];
      key = "<leader>ghs";
      action = ":Gitsigns stage_hunk<CR>";
      options.desc = "Stage Hunk";
    }
    {
      mode = [
        "n"
        "x"
      ];
      key = "<leader>ghr";
      action = ":Gitsigns reset_hunk<CR>";
      options.desc = "Reset Hunk";
    }
    {
      mode = "n";
      key = "<leader>ghS";
      action.__raw = "function() require('gitsigns').stage_buffer() end";
      options.desc = "Stage Buffer";
    }
    {
      mode = "n";
      key = "<leader>ghu";
      action.__raw = "function() require('gitsigns').undo_stage_hunk() end";
      options.desc = "Undo Stage Hunk";
    }
    {
      mode = "n";
      key = "<leader>ghR";
      action.__raw = "function() require('gitsigns').reset_buffer() end";
      options.desc = "Reset Buffer";
    }
    {
      mode = "n";
      key = "<leader>ghp";
      action.__raw = "function() require('gitsigns').preview_hunk_inline() end";
      options.desc = "Preview Hunk Inline";
    }
    {
      mode = "n";
      key = "<leader>ghb";
      action.__raw = "function() require('gitsigns').blame_line({ full = true }) end";
      options.desc = "Blame Line";
    }
    {
      mode = "n";
      key = "<leader>ghB";
      action.__raw = "function() require('gitsigns').blame() end";
      options.desc = "Blame Buffer";
    }
    {
      mode = "n";
      key = "<leader>ghd";
      action.__raw = "function() require('gitsigns').diffthis() end";
      options.desc = "Diff This";
    }
    {
      mode = "n";
      key = "<leader>ghD";
      action.__raw = "function() require('gitsigns').diffthis('~') end";
      options.desc = "Diff This ~";
    }
    {
      mode = [
        "o"
        "x"
      ];
      key = "ih";
      action = ":<C-U>Gitsigns select_hunk<CR>";
      options.desc = "GitSigns Select Hunk";
    }
  ];
}
