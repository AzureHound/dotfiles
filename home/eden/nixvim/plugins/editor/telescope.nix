{
  plugins.telescope = {
    enable = true;
    lazyLoad.settings.cmd = [ "Telescope" ];

    extensions = {
      fzf-native.enable = true;
      ui-select.enable = true;
    };

    settings.defaults = {
      selection_caret = " ";
      set_env.COLORTERM = "truecolor";
      layout_strategy = "horizontal";
      layout_config = {
        horizontal = {
          preview_width = 0.6;
          preview_cutoff = 0;
        };
      };
      file_ignore_patterns = [
        "^.git/"
        "^.mypy_cache/"
        "^__pycache__/"
        "^output/"
        "^data/"
        "%.ipynb"
      ];
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>tt";
      action = "<cmd>Telescope<cr>";
      options.desc = "Telescope";
    }
  ];
}
