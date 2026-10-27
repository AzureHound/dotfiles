-- █ █ ▄▀█ █▀█ █ ▄▀█ █▄▄ █   █▀▀ █▀
-- ▀▄▀ █▀█ █▀▄ █ █▀█ █▄█ █▄▄ ██▄ ▄█

local bar = "waybar"
local notifications = "swaync-client"
local browser_ALT = "firefox"
local shell = "zsh -c "
local term = "kitty"

local variables = {
  launcher = "rofi -show drun",
  pypr = "pypr-client",

  bar = {
    launch = bar,
    toggle = "killall -SIGUSR1 " .. bar,
    reload = "killall " .. bar .. "; " .. bar,
  },

  notifications = {
    launch = notifications,
    read = notifications .. " -C",
    toggle = notifications .. " -t -sw",
    disturb = notifications .. " -d",
    reload = notifications .. " -R && " .. notifications .. " -rs",
  },

  browser = "zen-beta",
  browser_ALT = browser_ALT,
  editor = term .. " -e nvim",
  editor_gui = "zeditor",
  file_mgr = shell .. " yazi",
  file_mgr_gui = "nautilus --new-window",
  mail = "thunderbird",
  notes = term .. " -e nvim +'Obsidian quick_switch'",
  -- notes = "obsidian -disable-gpu",
  shell = shell,
  term = term,
  term_ALT = "footclient",
  -- term_ALT = "ghostty --gtk-single-instance=true",
  tmux = term .. " --class multiplexer -e",
  webapp = browser_ALT .. " --new-window",

  binds = {
    mainMod = "SUPER",
    hyper = "MOD3",
    modShift = "SUPER + SHIFT",
    modCtrl = "SUPER + CTRL",
    modAlt = "SUPER + ALT",
  },
}

return variables
