-- █   ▄▀█ █ █ █▄ █ █▀▀ █ █
-- █▄▄ █▀█ █▄█ █ ▀█ █▄▄ █▀█

local function exec_once(cmd) hl.exec_cmd(cmd) end

hl.on("hyprland.start", function()
  -- █▀ █▀▀ █▀█ █ █ █ █▀▀ █▀▀ █▀
  -- ▄█ ██▄ █▀▄ ▀▄▀ █ █▄▄ ██▄ ▄█

  -- exec_once("xwayland-satellite")
  -- exec_once("swww-daemon --format xrgb")
  -- exec_once(os.getenv("HOME") .. "/Developer/dotfiles/config/configHome/hypr/scripts/mpvpaper -i 30")
  -- exec_once("devify")
  exec_once("openrgb --server -p 'Profile 1'")
  exec_once("pypr --debug /tmp/pypr.log")
  -- exec_once("neru launch")
  exec_once("rm -f ~/.cache/cliphist/db")

  -- ▄▀█ █▀█ █▀█ █▀
  -- █▀█ █▀▀ █▀▀ ▄█

  -- Apps
  -- exec_once("thunderbird")
  -- exec_once("obsidian -disable-gpu")

  -- Term Apps
  -- exec_once("kitty --class btop btop")
  -- exec_once("kitty --class nvitop nvitop")
  -- exec_once("ghostty --gtk-single-instance=true --quit-after-last-window-closed=false --initial-window=false")
end)
