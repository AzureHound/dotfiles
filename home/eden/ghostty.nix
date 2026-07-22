{
  programs.ghostty = {
    package = null;

    settings = {
      # background-opacity = 0.90;
      # background-blur = 20;

      adjust-cell-height = "20%";
      font-size = 19;

      window-padding-x = "5,5";
      window-padding-y = "4,5";
      window-padding-balance = true;

      cursor-style = "bar";
      cursor-click-to-move = true;
      adjust-cursor-thickness = 3;

      macos-icon = "blueprint";
      macos-option-as-alt = true;
      # macos-window-buttons = "hidden";
      macos-titlebar-proxy-icon = "hidden";

      title = "‎";
      maximize = true;
      auto-update = "off";
      term = "xterm-256color";
      focus-follows-mouse = true;
      confirm-close-surface = false;
      mouse-hide-while-typing = true;
      window-colorspace = "display-p3";
      selection-clear-on-copy = true;
      shell-integration-features = true;
      window-inherit-working-directory = false;
      quit-after-last-window-closed = true;

      keybind = [
        "global:cmd+escape=toggle_quick_terminal"
      ];
    };
  };
}
