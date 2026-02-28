{
  plugins.colorful-winsep = {
    enable = true;
    lazyLoad.settings.event = [
      "WinNew"
      "WinLeave"
    ];

    settings = {
      hi = {
        bg = "#24273a";
        fg = "#c6a0f6";
      };
      excluded_ft = [
        "edgy"
        "netrw"
        "grug-far"
        "outline"
        "snacks_dashboard"
        "snacks_picker"
        "startuptime"
        "symbols-outline"
        "TelescopePrompt"
        "trouble"
      ];
    };
  };
}
