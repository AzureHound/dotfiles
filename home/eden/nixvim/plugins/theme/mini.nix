{
  plugins.mini = {
    enable = true;

    mockDevIcons = true;
    modules.icons = {
      file = {
        ".keep" = {
          glyph = "󰊢";
          hl = "MiniIconsGrey";
        };
        "devcontainer.json" = {
          glyph = "";
          hl = "MiniIconsAzure";
        };
      };
      filetype.dotenv = {
        glyph = "";
        hl = "MiniIconsYellow";
      };
    };
  };
}
