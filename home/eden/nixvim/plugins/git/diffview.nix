{
  plugins.diffview = {
    enable = true;
    lazyLoad.settings = {
      cmd = [
        "DiffviewOpen"
        "DiffviewClose"
        "DiffviewFileHistory"
        "DiffviewToggleFiles"
        "DiffviewFocusFiles"
      ];
    };

    settings = {
      enhanced_diff_hl = true;
      view = {
        default.winbar_info = true;
        file_history.winbar_info = true;
      };
      file_panel.win_config.position = "right";
      hooks.diff_buf_read.__raw = ''
        function(bufnr)
          vim.b[bufnr].view_activated = false
        end
      '';

      keymaps = {
        view = [
          {
            mode = "n";
            key = "<leader>gCo";
            action.__raw = "require('diffview.actions').conflict_choose('ours')";
            description = "Ours";
          }
          {
            mode = "n";
            key = "<leader>gCt";
            action.__raw = "require('diffview.actions').conflict_choose('theirs')";
            description = "Theirs";
          }
          {
            mode = "n";
            key = "<leader>gCb";
            action.__raw = "require('diffview.actions').conflict_choose('base')";
            description = "Base";
          }
          {
            mode = "n";
            key = "<leader>gCa";
            action.__raw = "require('diffview.actions').conflict_choose('all')";
            description = "All";
          }
          {
            mode = "n";
            key = "<leader>gCd";
            action.__raw = "require('diffview.actions').conflict_choose('none')";
            description = "Delete";
          }
          {
            mode = "n";
            key = "<leader>gCO";
            action.__raw = "require('diffview.actions').conflict_choose_all('ours')";
            description = "Ours (File)";
          }
          {
            mode = "n";
            key = "<leader>gCT";
            action.__raw = "require('diffview.actions').conflict_choose_all('theirs')";
            description = "Theirs (File)";
          }
          {
            mode = "n";
            key = "<leader>gCB";
            action.__raw = "require('diffview.actions').conflict_choose_all('base')";
            description = "Base (File)";
          }
          {
            mode = "n";
            key = "<leader>gCA";
            action.__raw = "require('diffview.actions').conflict_choose_all('all')";
            description = "All (File)";
          }
          {
            mode = "n";
            key = "<leader>gCD";
            action.__raw = "require('diffview.actions').conflict_choose_all('none')";
            description = "Delete (File)";
          }
        ];
        file_panel = [
          {
            mode = "n";
            key = "<leader>gCO";
            action.__raw = "require('diffview.actions').conflict_choose_all('ours')";
            description = "Ours (File)";
          }
          {
            mode = "n";
            key = "<leader>gCT";
            action.__raw = "require('diffview.actions').conflict_choose_all('theirs')";
            description = "Theirs (File)";
          }
          {
            mode = "n";
            key = "<leader>gCB";
            action.__raw = "require('diffview.actions').conflict_choose_all('base')";
            description = "Base (File)";
          }
          {
            mode = "n";
            key = "<leader>gCA";
            action.__raw = "require('diffview.actions').conflict_choose_all('all')";
            description = "All (File)";
          }
          {
            mode = "n";
            key = "<leader>gCX";
            action.__raw = "require('diffview.actions').conflict_choose_all('none')";
            description = "Delete (File)";
          }
        ];
      };
    };

    luaConfig.post = ''
      local function toggle_diffview(cmd)
        if next(require("diffview.lib").views) == nil then
          vim.cmd(cmd)
        else
          vim.cmd("DiffviewClose")
        end
      end

      vim.keymap.set("n", "<leader>gDD", function() toggle_diffview("DiffviewFileHistory") end, { desc = "Diff Repo" })
      vim.keymap.set("n", "<leader>gDd", function() toggle_diffview("DiffviewOpen") end, { desc = "Diff View" })
      vim.keymap.set("n", "<leader>gDf", function() toggle_diffview("DiffviewFileHistory %") end, { desc = "Diff Current File" })
      vim.keymap.set("n", "<leader>gDq", function() toggle_diffview("DiffviewClose") end, { desc = "Diff Close" })
    '';
  };
}
