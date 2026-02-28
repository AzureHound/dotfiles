{
  plugins.toggleterm = {
    enable = true;
    settings = {
      open_mapping.__raw = "[[<c-\\>]]";
      terminal_mappings = true;
      size = 24;
      float_opts = {
        border = "curved";
        width = 110;
        height = 24;
        winblend = 0;
      };
    };
  };

  keymaps = [
    {
      mode = [
        "n"
        "t"
      ];
      key = "<c-/>";
      action = "<cmd>ToggleTerm id=1 dir=~<cr>";
      options.desc = "Toggle Term";
    }
    {
      mode = [
        "n"
        "t"
      ];
      key = "<c-_>";
      action = "<cmd>ToggleTerm id=2<cr>";
      options.desc = "Toggle Term";
    }
    {
      mode = [
        "n"
        "t"
      ];
      key = "<c-->";
      action = "<cmd>3ToggleTerm direction=horizontal<cr>";
      options.desc = "Toggle Horizontal Term";
    }
    {
      mode = "n";
      key = "<leader>tf";
      action = "<cmd>4ToggleTerm direction=float<cr>";
      options.desc = "Toggle Floating Term";
    }
  ];

  extraConfigLua = ''
    local Terminal = require("toggleterm.terminal").Terminal
    local vterm = Terminal:new({ direction = "vertical", count = 2 })
    vim.keymap.set({"n","t"}, "<c-\\\\>", function() vterm:toggle() end, { desc = "Toggle Vertical Term" })
  '';
}
