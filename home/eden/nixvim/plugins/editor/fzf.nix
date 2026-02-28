{
  plugins = {
    fzf-lua = {
      enable = true;
      lazyLoad.settings.cmd = [ "FzfLua" ];

      profile = "fzf-native";
      settings = {
        winopts = {
          height = 0.95;
          width = 0.95;
          preview.horizontal = "right:70%";
        };
        previewers = {
          bat = {
            cmd = "bat";
            args = "--color=always --style=numbers,changes --theme='Catppuccin Macchiato'";
          };
        };
      };
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>FF";
      action = "<cmd>FzfLua<cr>";
      options.desc = "Fzf";
    }
  ];
}
