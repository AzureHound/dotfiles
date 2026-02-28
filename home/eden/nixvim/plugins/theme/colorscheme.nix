{
  colorschemes.catppuccin = {
    enable = true;

    settings = {
      flavour = "macchiato";
      background = {
        light = "frappe";
        dark = "macchiato";
      };
      transparent_background = true;
      float.transparent = true;
      term_colors = true;
      styles.booleans = [
        "bold"
        "italic"
      ];
      integrations = {
        bufferline = true;
        diffview = true;
        grug_far = true;
        harpoon = true;
        lsp_trouble = true;
        native_lsp.enabled = true;
        neotest = true;
        noice = true;
        notify = true;
        octo = true;
        render_markdown = true;
        which_key = true;
      };
    };
  };
}
