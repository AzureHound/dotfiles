{
  plugins.snacks = {
    enable = true;

    luaConfig.pre = ''
      _G.term_nav = function(dir)
        return function(self)
          return self:is_floating() and "<c-" .. dir .. ">" or vim.schedule(function()
            vim.cmd.wincmd(dir)
          end)
        end
      end
    '';

    settings = {
      bigfile.enabled = true;
      quickfile.enabled = true;
      terminal.win.keys = {
        nav_h = [
          "<C-h>"
          { __raw = "_G.term_nav('h')"; }
          {
            desc = "Go to Left Window";
            expr = true;
            mode = "t";
          }
        ];
        nav_j = [
          "<C-j>"
          { __raw = "_G.term_nav('j')"; }
          {
            desc = "Go to Lower Window";
            expr = true;
            mode = "t";
          }
        ];
        nav_k = [
          "<C-k>"
          { __raw = "_G.term_nav('k')"; }
          {
            desc = "Go to Upper Window";
            expr = true;
            mode = "t";
          }
        ];
        nav_l = [
          "<C-l>"
          { __raw = "_G.term_nav('l')"; }
          {
            desc = "Go to Right Window";
            expr = true;
            mode = "t";
          }
        ];
        hide_slash = [
          "<C-/>"
          "hide"
          {
            desc = "Hide Terminal";
            mode = "t";
          }
        ];
        hide_underscore = [
          "<c-_>"
          "hide"
          {
            desc = "which_key_ignore";
            mode = "t";
          }
        ];
      };
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>.";
      action.__raw = "function() Snacks.scratch() end";
      options.desc = "Toggle Scratch Buffer";
    }
    {
      mode = "n";
      key = "<leader>S";
      action.__raw = "function() Snacks.scratch.select() end";
      options.desc = "Select Scratch Buffer";
    }
    {
      mode = "n";
      key = "<leader>dps";
      action.__raw = "function() Snacks.profiler.scratch() end";
      options.desc = "Profiler Scratch Buffer";
    }
  ];
}
