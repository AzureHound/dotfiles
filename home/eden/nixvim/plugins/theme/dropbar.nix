{
  plugins.dropbar.enable = true;

  keymaps = [
    {
      mode = "n";
      key = "=";
      action.__raw = "function() require('dropbar.api').pick() end";
      options.desc = "Dropbar Pick";
    }
  ];
}
