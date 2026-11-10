{ pkgs, config, ... }:

{
  services.clipse = {
    enable = pkgs.stdenv.hostPlatform.isLinux && config.pixel.profiles.graphical.enable;

    settings = {
      allowDuplicates = false;
      maxHistory = 1000;
      historyFile = "clipboard_history.json";
      logFile = "clipse.log";
      themeFile = "custom_theme.json";
      tempDir = "tmp_files";
      imageDisplay = {
        type = if config.programs.sway.enable then "sixel" else "kitty";
        scaleX = 17;
        scaleY = 17;
        # heightCut = 2;
      };
      keyBindings = {
        choose = "enter";
        clearSelected = "S";
        down = "j,down";
        end = "G,end";
        filter = "/";
        forceQuit = "Q";
        home = "g,home";
        more = "?";
        nextPage = "l,right";
        prevPage = "h,left";
        preview = "space";
        quit = "q,esc";
        remove = "d,backspace,delete";
        selectDown = "shift+j,shift+down";
        selectSingle = "s";
        selectUp = "shift+k,shift+up";
        togglePin = "p";
        togglePinned = "tab";
        up = "k,up";
        yankFilter = "y";
      };
    };
  };
}
