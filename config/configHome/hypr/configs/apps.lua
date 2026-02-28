-- █   ▄▀█ █ █ █▄ █ █▀▀ █ █
-- █▄▄ █▀█ █▄█ █ ▀█ █▄▄ █▀█

---@diagnostic disable: lowercase-global
-- stylua: ignore start

launcher = "rofi -show drun"
pypr = "pypr-client"

bar = "waybar"
bar_toggle = "killall -SIGUSR1 " .. bar
bar_reload = "killall " .. bar .. "; " .. bar

notifications_menu         = "swaync-client"
notifications_menu_read    = notifications_menu .. " -C"
notifications_menu_toggle  = notifications_menu .. " -t -sw"
notifications_menu_disturb = notifications_menu .. " -d"
notifications_menu_reload  = notifications_menu .. " -R && " .. notifications_menu .. " -rs"

browser          = "zen-beta"
browser_ALT      = "firefox"
term             = "kitty"
editor           = term .. " -e nvim"
editor_gui       = "zeditor"
shell            = "zsh -c "
file_mgr         = shell .. " yazi"
file_mgr_gui     = "nautilus --new-window"
mail             = "thunderbird"
tmux             = term .. " --class multiplexer -e"
notes            = term .. " -e nvim +'Obsidian quick_switch'"
-- notes            = "obsidian -disable-gpu"
term_ALT         = "footclient"
-- term_ALT         = "ghostty --gtk-single-instance=true"
webapp           = browser_ALT .. " --new-window"
