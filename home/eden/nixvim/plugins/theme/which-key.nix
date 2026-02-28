{
  plugins.which-key = {
    enable = true;
    settings.preset = "helix";
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>?";
      action.__raw = "function() require('which-key').show({ global = false }) end";
      options.desc = "Buffer Keymaps (which-key)";
    }
  ];
}
