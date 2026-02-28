{
  plugins.package-info = {
    enable = true;
    lazyLoad.settings = {
      event = [ "BufRead package.json" ];
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>fP";
      action = "<cmd>Telescope package_info<cr>";
      options.desc = "Find Package Info";
    }
  ];
}
