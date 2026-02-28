{
  plugins.kitty-scrollback = {
    enable = true;
    lazyLoad.settings = {
      cmd = [
        "KittyScrollbackGenerateKittens"
        "KittyScrollbackCheckHealth"
        "KittyScrollbackGenerateCommandLineEditing"
      ];
      event = [ "User KittyScrollbackLaunch" ];
    };

    settings.status_window.icons.nvim = "";
  };
}
