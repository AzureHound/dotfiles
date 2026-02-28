{
  plugins.img-clip = {
    enable = true;
    lazyLoad.settings.cmd = [ "PasteImage" ];

    settings.default.prompt_for_file_name = false;
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>P";
      action = "<cmd>PasteImage<cr>";
      options.desc = "Paste Image from Clipboard";
    }
  ];
}
