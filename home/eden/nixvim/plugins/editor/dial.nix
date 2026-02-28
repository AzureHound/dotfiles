{
  plugins.dial.enable = true;

  keymaps = [
    {
      mode = "n";
      key = "<C-x>";
      action = "<cmd>lua require('dial.map').manipulate('increment', 'normal')<cr>";
    }
    {
      mode = "n";
      key = "<C-z>";
      action = "<cmd>lua require('dial.map').manipulate('decrement', 'normal')<cr>";
    }
    {
      mode = "v";
      key = "<C-x>";
      action = "<cmd>lua require('dial.map').manipulate('increment', 'visual')<cr>";
    }
    {
      mode = "v";
      key = "<C-z>";
      action = "<cmd>lua require('dial.map').manipulate('decrement', 'visual')<cr>";
    }
  ];

  extraConfigLua = ''
    local a = require("dial.augend")
    require("dial.config").augends:register_group {
      default = {
        a.integer.alias.decimal,
        a.integer.alias.hex,
        a.constant.alias.bool,
        a.constant.alias.Bool,
      },
    }
  '';
}
