{
  plugins = {
    markdown-preview = {
      enable = true;
      lazyLoad.settings.cmd = [
        "MarkdownPreview"
        "MarkdownPreviewStop"
        "MarkdownPreviewToggle"
      ];

      settings = {
        browser = "firefox";
        echo_preview_url = 1;
        port = "6969";
        preview_options = {
          disable_filename = 1;
          disable_sync_scroll = 1;
        };
        theme = "dark";
      };
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>mp";
      action = "<cmd>MarkdownPreview<cr>";
      options = {
        desc = "Toggle Markdown Preview";
      };
    }
  ];
}
