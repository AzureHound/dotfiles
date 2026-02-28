{
  plugins = {
    todo-comments = {
      enable = true;
      lazyLoad.settings = {
        event = [
          "BufReadPre"
          "BufNewFile"
        ];
      };

      settings = {
        keywords = {
          HACK = {
            icon = "󰈸 ";
            color = "warning";
          };
          PERF = {
            icon = "󱑁 ";
            alt = [
              "OPTIM"
              "PERFORMANCE"
              "OPTIMIZE"
            ];
          };
          NOTE = {
            icon = " ";
            color = "hint";
            alt = [ "INFO" ];
          };
          TEST = {
            icon = "󰙨 ";
            color = "test";
            alt = [
              "TESTING"
              "PASSED"
              "FAILED"
            ];
          };
        };
        colors = {
          error = [
            "DiagnosticError"
            "ErrorMsg"
            "#ed8796"
          ];
          warning = [
            "DiagnosticWarn"
            "WarningMsg"
            "#eed49f"
          ];
          info = [
            "DiagnosticInfo"
            "#8aadf4"
          ];
          hint = [
            "DiagnosticHint"
            "#a6da95"
          ];
          default = [
            "Identifier"
            "#b7bdf8"
          ];
          test = [
            "Identifier"
            "#c6a0f6"
          ];
        };
      };
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "]t";
      action.__raw = "function() require('todo-comments').jump_next() end";
      options.desc = "Next Todo Comment";
    }
    {
      mode = "n";
      key = "[t";
      action.__raw = "function() require('todo-comments').jump_prev() end";
      options.desc = "Previous Todo Comment";
    }
    {
      mode = "n";
      key = "<leader>xt";
      action = "<cmd>Trouble todo toggle<cr>";
      options.desc = "Todo (Trouble)";
    }
    {
      mode = "n";
      key = "<leader>xT";
      action = "<cmd>Trouble todo toggle filter = {tag = {TODO,FIX,FIXME}}<cr>";
      options.desc = "Todo/Fix/Fixme (Trouble)";
    }
    {
      mode = "n";
      key = "<leader>st";
      action = "<cmd>TodoTelescope<cr>";
      options.desc = "Todo";
    }
    {
      mode = "n";
      key = "<leader>sT";
      action = "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>";
      options.desc = "Todo/Fix/Fixme";
    }
  ];
}
