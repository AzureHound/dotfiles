local vars = require("configs.vars")
local mods = vars.binds

hl.config({
  binds = {
    allow_pin_fullscreen = true,
    allow_workspace_cycles = true,
    workspace_center_on = 1,
    workspace_back_and_forth = false,
  },
})

-- █ █ ▄▀█ █▀█ █ ▄▀█ █▄▄ █   █▀▀ █▀
-- ▀▄▀ █▀█ █▀▄ █ █▀█ █▄█ █▄▄ ██▄ ▄█

local home = os.getenv("HOME")
local bin = home .. "/.local/bin"
local scripts = home .. "/.config/hypr/scripts"
local launcher_scripts = home .. "/.config/rofi/scripts"

local moveactivewindow =
  'grep -q "true" <<< $(hyprctl activewindow -j | jq -r .floating) && hyprctl dispatch moveactive'

local function launch(cmd) return cmd .. " & disown; hyprctl dispatch submap reset" end

-- █▄▀ █▀▀ █▄█ █▄▄ █ █▄ █ █▀▄ █ █▄ █ █▀▀ █▀
-- █ █ ██▄  █  █▄█ █ █ ▀█ █▄▀ █ █ ▀█ █▄█ ▄█

-- hl.bind(mods.mainMod .. " + P", hl.dsp.window.pin())
hl.bind(mods.mainMod .. " + P", hl.dsp.exec_cmd(scripts .. "/pin"))
-- hl.bind(mods.mainMod .. " + O", hl.dsp.window.pseudo())
hl.bind(mods.mainMod .. " + S", hl.dsp.layout("togglesplit"))
hl.bind(mods.mainMod .. " + F", hl.dsp.window.fullscreen(0))
hl.bind(mods.modShift .. " + F", hl.dsp.window.fullscreen(1))
hl.bind(mods.mainMod .. " + U", hl.dsp.focus({ urgent_or_last = true }))
hl.bind(mods.mainMod .. " + SPACE", hl.dsp.exec_cmd(scripts .. "/toggle_floating"))
hl.bind(mods.mainMod .. " + " .. mods.hyper .. " + SPACE", hl.dsp.exec_cmd(scripts .. "/allfloat"))
hl.bind(mods.mainMod .. " + C", hl.dsp.window.center())
hl.bind(mods.mainMod .. " + " .. mods.hyper .. " + P", performance)
hl.bind(mods.mainMod .. " + " .. mods.hyper .. " + ESCAPE", hl.dsp.exec_cmd("wl-freeze -a -s"))
hl.bind(mods.modAlt .. " + BACKSPACE", hl.dsp.window.set_prop({ prop = "opaque", value = "toggle" }))
hl.bind(mods.mainMod .. " + ALT + SHIFT + BACKSPACE", hl.dsp.exec_cmd(scripts .. "/gaps"))
hl.bind(mods.modAlt .. " + 0", hl.dsp.exec_cmd(bin .. "/caffeine"))
hl.bind(mods.mainMod .. " + Q", kill)
hl.bind(mods.mainMod .. " + " .. mods.hyper .. " + R", hl.dsp.exec_cmd("hyprctl reload"))
hl.bind(mods.hyper .. " + CTRL + DELETE", hl.dsp.exit()) -- Kill Hyprland

-- Pickers/Launchers
hl.bind("ALT + SPACE", hl.dsp.exec_cmd(vars.launcher))
hl.bind(mods.hyper .. " + CTRL + E", hl.dsp.exec_cmd(scripts .. "/emoji"))
hl.bind(mods.hyper .. " + CTRL + G", hl.dsp.exec_cmd(scripts .. "/glyph"))
hl.bind(mods.hyper .. " + CTRL + S", hl.dsp.exec_cmd(scripts .. "/ocr"))
hl.bind(mods.hyper .. " + CTRL + C", hl.dsp.exec_cmd(scripts .. "/pigment"))
hl.bind(mods.hyper .. " + CTRL + R", hl.dsp.exec_cmd(bin .. "/screenrecord"))
-- hl.bind(mods.hyper .. " + CTRL + R + SPACE", hl.dsp.exec_cmd(bin .. "/screenrecord -a"))
hl.bind(mods.hyper .. " + ESCAPE + 9", hl.dsp.exec_cmd(scripts .. "/gamemode"))
hl.bind(mods.modCtrl .. " + W", hl.dsp.exec_cmd(scripts .. "/webcam"))
-- hl.bind(mods.hyper .. " + CTRL + E", hl.dsp.exec_cmd(launcher_scripts .. "/emoji/emoji"))
hl.bind(mods.modAlt .. " + SPACE", hl.dsp.exec_cmd(launcher_scripts .. "/windows/windows"))
-- hl.bind(mods.hyper .. " + CTRL + Y", hl.dsp.exec_cmd(launcher_scripts .. "/clipboard/clipboard"))
hl.bind(mods.mainMod .. " + ESCAPE", hl.dsp.exec_cmd(launcher_scripts .. "/powermenu/powermenu"))
hl.bind(mods.hyper .. " + RETURN", hl.dsp.exec_cmd(launcher_scripts .. "/game-launcher/game_launcher"))
hl.bind("PRINT", hl.dsp.exec_cmd(launcher_scripts .. "/screenshot/screenshot --freeze"))
hl.bind("CTRL + ESCAPE", hl.dsp.exec_cmd(launcher_scripts .. "/screenshot/screenshot --freeze"))
-- hl.bind("CTRL + ALT + M", hl.dsp.exec_cmd(vars.term .. " " .. bin .. "/hidpi"))
hl.bind(mods.mainMod .. " + I", hl.dsp.exec_cmd(vars.tmux .. " multiplexer"))
hl.bind(mods.hyper .. " + BACKSLASH", hl.dsp.exec_cmd("kitten quick-access-terminal"))

-- Notification Panel
hl.bind(mods.mainMod .. " + N", hl.dsp.exec_cmd(vars.notifications.toggle))
hl.bind(mods.modCtrl .. " + N", hl.dsp.exec_cmd(vars.notifications.read))
hl.bind(mods.modAlt .. " + N", hl.dsp.exec_cmd(vars.notifications.disturb))
hl.bind(mods.modShift .. " + N", hl.dsp.exec_cmd(vars.notifications.reload))

-- Wallpaper
-- hl.bind(mods.modShift .. " + W", hl.dsp.exec_cmd(vars.pypr .. " wall next"))
hl.bind(mods.modShift .. " + W", hl.dsp.exec_cmd(scripts .. "/wallpaper"))
hl.bind(mods.mainMod .. " + W", hl.dsp.exec_cmd(launcher_scripts .. "/wallpaper/wallpaper"))
-- hl.bind(mods.modShift .. " + W", hl.dsp.exec_cmd(scripts .. "/mpvpaper"))
-- hl.bind(mods.mainMod .. " + W", hl.dsp.exec_cmd(launcher_scripts .. "/wallpaper/mpvpaper"))

-- vars
hl.bind(mods.mainMod .. " + RETURN", hl.dsp.exec_cmd(vars.term))
hl.bind(mods.modShift .. " + RETURN", hl.dsp.exec_cmd(vars.term_ALT))
hl.bind(mods.mainMod .. " + B", hl.dsp.exec_cmd(vars.browser))
hl.bind(mods.hyper .. " + CTRL + P", hl.dsp.exec_cmd(vars.browser_ALT .. " --private-window"))
hl.bind(mods.mainMod .. " + E", hl.dsp.exec_cmd(vars.file_mgr))
hl.bind(mods.modShift .. " + E", hl.dsp.exec_cmd(vars.file_mgr_gui))

hl.bind(mods.mainMod .. " + A", hl.dsp.submap("vars"))
hl.define_submap("vars", function()
  hl.bind("A", hl.dsp.exec_cmd(launch("android-file-transfer")))
  hl.bind("C", hl.dsp.exec_cmd(launch("gnome-calculator")))
  -- hl.bind("E", hl.dsp.exec_cmd(launch("easyeffects")))
  -- hl.bind("F", hl.dsp.exec_cmd(launch("fragments")))
  hl.bind("O", hl.dsp.exec_cmd(launch(vars.notes)))
  hl.bind("Q", hl.dsp.exec_cmd(launch("qutebrowser")))
  hl.bind("S", hl.dsp.exec_cmd(launch("spotify")))
  hl.bind("T", hl.dsp.exec_cmd(launch(vars.mail)))
  -- hl.bind("V", hl.dsp.exec_cmd(launch("vscodium")))
  hl.bind("Y", hl.dsp.exec_cmd(launch("org.nickvision.tubeconverter")))
  hl.bind("X", hl.dsp.exec_cmd(launch(vars.editor_gui)))

  hl.bind("SHIFT + F", hl.dsp.exec_cmd(launch("firefox")))
  hl.bind("SHIFT + P", hl.dsp.exec_cmd(launch("packet")))
  hl.bind("SHIFT + S", hl.dsp.exec_cmd(launch("steam")))

  hl.bind("catchall", hl.dsp.submap("reset"))
end)

-- Web vars
hl.bind(mods.mainMod .. " + X", hl.dsp.submap("links"))
hl.define_submap("links", function()
  hl.bind("C", hl.dsp.exec_cmd(launch(vars.webapp .. " 'https://chatgpt.com/?temporary-chat=true'")))
  hl.bind("G", hl.dsp.exec_cmd(launch(vars.webapp .. " 'https://gemini.google.com/app'")))
  hl.bind("P", hl.dsp.exec_cmd(launch(vars.webapp .. " 'https://perplexity.ai'")))
  hl.bind("Q", hl.dsp.exec_cmd(launch(vars.webapp .. " 'https://chat.qwen.ai'")))
  hl.bind("S", hl.dsp.exec_cmd(launch(vars.webapp .. " 'https://web.localsend.org'")))
  hl.bind("X", hl.dsp.exec_cmd(launch(vars.webapp .. " 'https://grok.com/'")))
  hl.bind("Y", hl.dsp.exec_cmd(launch(vars.webapp .. " 'https://youtube.com'")))

  hl.bind("SHIFT + G", hl.dsp.exec_cmd(launch(vars.webapp .. " 'https://github.com/azurehound'")))

  hl.bind("catchall", hl.dsp.submap("reset"))
end)

-- Scratchpads
hl.bind(mods.hyper .. " + CTRL + W", hl.dsp.exec_cmd(vars.pypr .. " toggle impala"))
hl.bind(mods.hyper .. " + CTRL + B", hl.dsp.exec_cmd(vars.pypr .. " toggle bluetui"))
hl.bind(mods.mainMod .. " + V", hl.dsp.exec_cmd(vars.pypr .. " toggle wiremix"))
hl.bind(mods.hyper .. " + CTRL + Y", hl.dsp.exec_cmd(vars.pypr .. " toggle clipboard"))

hl.bind(mods.mainMod .. " + BACKSLASH", hl.dsp.exec_cmd(vars.pypr .. " toggle term"))
hl.bind(mods.mainMod .. " + T", hl.dsp.exec_cmd(vars.pypr .. " toggle tty-clock"))
hl.bind(mods.hyper .. " + CTRL + N", hl.dsp.exec_cmd(vars.pypr .. " toggle quick-note"))

hl.bind(mods.hyper .. " + B", hl.dsp.exec_cmd(vars.pypr .. " toggle btop"))
hl.bind(mods.hyper .. " + D", hl.dsp.exec_cmd(vars.pypr .. " toggle lazydocker"))
hl.bind(mods.hyper .. " + G", hl.dsp.exec_cmd(vars.pypr .. " toggle nvitop"))
-- hl.bind(mods.hyper .. " + I", hl.dsp.exec_cmd(vars.pypr .. " toggle tgpt"))
hl.bind(mods.hyper .. " + J", hl.dsp.exec_cmd(vars.pypr .. " toggle jelly"))
hl.bind(mods.hyper .. " + L", hl.dsp.exec_cmd(vars.pypr .. " toggle lofi"))
hl.bind(mods.hyper .. " + M", hl.dsp.exec_cmd(vars.pypr .. " toggle neomutt"))
hl.bind(mods.hyper .. " + N", hl.dsp.exec_cmd(vars.pypr .. " toggle neovim"))
hl.bind(mods.hyper .. " + O", hl.dsp.exec_cmd(vars.pypr .. " toggle obsidian"))
hl.bind(mods.hyper .. " + P", hl.dsp.exec_cmd(vars.pypr .. " toggle pomodoro"))
hl.bind(mods.hyper .. " + S", hl.dsp.exec_cmd(vars.pypr .. " toggle sounds"))
hl.bind(mods.hyper .. " + T", hl.dsp.exec_cmd(vars.pypr .. " toggle todo"))
hl.bind(mods.hyper .. " + W", hl.dsp.exec_cmd(vars.pypr .. " toggle weather"))
hl.bind(mods.hyper .. " + V", hl.dsp.exec_cmd(vars.pypr .. " toggle vim"))
hl.bind(mods.hyper .. " + X", hl.dsp.exec_cmd(vars.pypr .. " toggle tt"))
hl.bind(mods.hyper .. " + Y", hl.dsp.exec_cmd(vars.pypr .. " toggle yazi"))

-- Focusing
-- hl.bind(mods.mainMod .. " + TAB", hl.dsp.focus({ last = true }))
hl.bind(mods.mainMod .. " + TAB", hl.dsp.focus({ workspace = "previous" }))
hl.bind(mods.mainMod .. " + BACKSPACE", hl.dsp.exec_cmd(scripts .. "/toggle_focus"))

-- hl.bind(mods.mainMod .. " + H", hl.dsp.focus({ direction = "l" }))
-- hl.bind(mods.mainMod .. " + J", hl.dsp.focus({ direction = "d" }))
-- hl.bind(mods.mainMod .. " + K", hl.dsp.focus({ direction = "u" }))
-- hl.bind(mods.mainMod .. " + L", hl.dsp.focus({ direction = "r" }))

-- hl.bind(mods.mainMod .. " + LEFT", hl.dsp.focus({ direction = "l" }))
-- hl.bind(mods.mainMod .. " + UP", hl.dsp.focus({ direction = "u" }))
-- hl.bind(mods.mainMod .. " + DOWN", hl.dsp.focus({ direction = "d" }))
-- hl.bind(mods.mainMod .. " + RIGHT", hl.dsp.focus({ direction = "r" }))

--- Window on Top
hl.bind("ALT + Tab", function()
  hl.dispatch(hl.dsp.window.cycle_next())
  hl.dispatch(hl.dsp.window.alter_zorder({ mode = "top" }))
end)

-- FIXME:
hl.bind(mods.mainMod .. " + H", hl.dsp.window.alter_zorder({ mode = "top" }))
hl.bind(mods.mainMod .. " + J", hl.dsp.window.alter_zorder({ mode = "top" }))
hl.bind(mods.mainMod .. " + K", hl.dsp.window.alter_zorder({ mode = "top" }))
hl.bind(mods.mainMod .. " + L", hl.dsp.window.alter_zorder({ mode = "top" }))

hl.bind(mods.mainMod .. " + LEFT", hl.dsp.window.alter_zorder({ mode = "top" }))
hl.bind(mods.mainMod .. " + UP", hl.dsp.window.alter_zorder({ mode = "top" }))
hl.bind(mods.mainMod .. " + DOWN", hl.dsp.window.alter_zorder({ mode = "top" }))
hl.bind(mods.mainMod .. " + RIGHT", hl.dsp.window.alter_zorder({ mode = "top" }))

--- Pypr
hl.bind(mods.mainMod .. " + " .. mods.hyper .. " + M", hl.dsp.exec_cmd(vars.pypr .. " layout_center toggle"))

hl.bind(mods.mainMod .. " + H", hl.dsp.exec_cmd(vars.pypr .. " layout_center prev"))
hl.bind(mods.mainMod .. " + J", hl.dsp.exec_cmd(vars.pypr .. " layout_center next2"))
hl.bind(mods.mainMod .. " + K", hl.dsp.exec_cmd(vars.pypr .. " layout_center prev2"))
hl.bind(mods.mainMod .. " + L", hl.dsp.exec_cmd(vars.pypr .. " layout_center next"))

hl.bind(mods.mainMod .. " + LEFT", hl.dsp.exec_cmd(vars.pypr .. " layout_center prev"))
hl.bind(mods.mainMod .. " + UP", hl.dsp.exec_cmd(vars.pypr .. " layout_center prev2"))
hl.bind(mods.mainMod .. " + DOWN", hl.dsp.exec_cmd(vars.pypr .. " layout_center next2"))
hl.bind(mods.mainMod .. " + RIGHT", hl.dsp.exec_cmd(vars.pypr .. " layout_center next"))

-- █▀▄▀█ █▀█ █ █ █▀▀
-- █ ▀ █ █▄█ ▀▄▀ ██▄

hl.bind(mods.mainMod .. " + " .. mods.hyper .. " + BACKSPACE", hl.dsp.exec_cmd(scripts .. "/move_by_rules"))

hl.bind(mods.modShift .. " + H", hl.dsp.window.move({ direction = "l" }))
hl.bind(mods.modShift .. " + J", hl.dsp.window.move({ direction = "d" }))
hl.bind(mods.modShift .. " + K", hl.dsp.window.move({ direction = "u" }))
hl.bind(mods.modShift .. " + L", hl.dsp.window.move({ direction = "r" }))

hl.bind(
  mods.modShift .. " + LEFT",
  hl.dsp.exec_cmd(moveactivewindow .. " -10 0 || hyprctl dispatch movewindow l"),
  { repeating = true, locked = true }
)
hl.bind(
  mods.modShift .. " + UP",
  hl.dsp.exec_cmd(moveactivewindow .. " 0 -10 || hyprctl dispatch movewindow u"),
  { repeating = true, locked = true }
)
hl.bind(
  mods.modShift .. " + DOWN",
  hl.dsp.exec_cmd(moveactivewindow .. " 0 10  || hyprctl dispatch movewindow d"),
  { repeating = true, locked = true }
)
hl.bind(
  mods.modShift .. " + RIGHT",
  hl.dsp.exec_cmd(moveactivewindow .. " 10 0  || hyprctl dispatch movewindow r"),
  { repeating = true, locked = true }
)

-- Groups
hl.bind(mods.mainMod .. " + G", hl.dsp.group.toggle())
hl.bind(mods.modShift .. " + G", hl.dsp.window.move({ out_of_group = true }))
hl.bind(mods.mainMod .. " + " .. mods.hyper .. " + G", hl.dsp.group.lock_active({ action = "toggle" }))

-- Moving in group
hl.bind(mods.hyper .. " + CTRL + TAB", hl.dsp.group.next())
hl.bind(mods.modAlt .. " + SHIFT + TAB", hl.dsp.group.prev())

-- Moving in group [Mouse]
hl.bind(mods.modCtrl .. " + mouse_up", hl.dsp.group.next())
hl.bind(mods.modCtrl .. " + mouse_down", hl.dsp.group.prev())

-- Moving to TAB
hl.bind(mods.modAlt .. " + 1", hl.dsp.group.active({ index = 1 }))
hl.bind(mods.modAlt .. " + 2", hl.dsp.group.active({ index = 2 }))
hl.bind(mods.modAlt .. " + 3", hl.dsp.group.active({ index = 3 }))
hl.bind(mods.modAlt .. " + 4", hl.dsp.group.active({ index = 4 }))
hl.bind(mods.modAlt .. " + 5", hl.dsp.group.active({ index = 5 }))

-- █▀█ █▀▀ █▀ █ ▀█ █▀▀
-- █▀▄ ██▄ ▄█ █ █▄ ██▄

hl.bind(mods.mainMod .. " + R", hl.dsp.submap("resize"))
hl.define_submap("resize", function()
  hl.bind("H", hl.dsp.window.resize({ x = -40, y = 0, relative = true }), { repeating = true })
  hl.bind("J", hl.dsp.window.resize({ x = 0, y = 40, relative = true }), { repeating = true })
  hl.bind("K", hl.dsp.window.resize({ x = 0, y = -40, relative = true }), { repeating = true })
  hl.bind("L", hl.dsp.window.resize({ x = 40, y = 0, relative = true }), { repeating = true })

  hl.bind("LEFT", hl.dsp.window.resize({ x = -40, y = 0, relative = true }), { repeating = true })
  hl.bind("UP", hl.dsp.window.resize({ x = 0, y = -40, relative = true }), { repeating = true })
  hl.bind("DOWN", hl.dsp.window.resize({ x = 0, y = 40, relative = true }), { repeating = true })
  hl.bind("RIGHT", hl.dsp.window.resize({ x = 40, y = 0, relative = true }), { repeating = true })

  hl.bind("ESCAPE", hl.dsp.submap("reset"))
end)

-- Window Split
hl.bind(mods.mainMod .. " + MINUS", hl.dsp.exec_cmd("hyprctl dispatch splitratio -0.1"))
hl.bind(mods.mainMod .. " + EQUAL", hl.dsp.exec_cmd("hyprctl dispatch splitratio +0.1"))

-- █   █ █▀█ █▀█ █▄▀ █▀ █▀█ ▄▀█ █▀▀ █▀▀ █▀
-- █▄▀▄█ █▄█ █▀▄ █ █ ▄█ █▀▀ █▀█ █▄▄ ██▄ ▄█

-- Workspaces 1..10
for i = 1, 10 do
  local key = i % 10 -- 10 -> 0
  hl.bind(mods.mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
  hl.bind(mods.modShift .. " + " .. key, hl.dsp.window.move({ workspace = i }))
  hl.bind(mods.modCtrl .. " + " .. key, hl.dsp.window.move({ workspace = i, follow = false }))
end

-- Moving to Workspace
hl.bind(mods.modCtrl .. " + H", hl.dsp.focus({ workspace = "m-1" }))
hl.bind(mods.modCtrl .. " + J", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mods.modCtrl .. " + K", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mods.modCtrl .. " + L", hl.dsp.focus({ workspace = "m+1" }))

hl.bind(mods.modCtrl .. " + LEFT", hl.dsp.focus({ workspace = "m-1" }))
hl.bind(mods.modCtrl .. " + DOWN", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mods.modCtrl .. " + UP", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mods.modCtrl .. " + RIGHT", hl.dsp.focus({ workspace = "m+1" }))

hl.bind(mods.hyper .. " + SHIFT + H", hl.dsp.window.move({ workspace = "r-1" }))
hl.bind(mods.hyper .. " + SHIFT + L", hl.dsp.window.move({ workspace = "r+1" }))

hl.bind(mods.hyper .. " + SHIFT + BRACKETLEFT", hl.dsp.window.move({ workspace = "r-1" }))
hl.bind(mods.hyper .. " + SHIFT + BRACKETRIGHT", hl.dsp.window.move({ workspace = "r+1" }))

hl.bind(mods.hyper .. " + CTRL + H", hl.dsp.window.move({ workspace = "r-1", follow = false }))
hl.bind(mods.hyper .. " + CTRL + L", hl.dsp.window.move({ workspace = "r+1", follow = false }))

hl.bind(mods.hyper .. " + CTRL + BRACKETLEFT", hl.dsp.window.move({ workspace = "r-1", follow = false }))
hl.bind(mods.hyper .. " + CTRL + BRACKETRIGHT", hl.dsp.window.move({ workspace = "r+1", follow = false }))

-- Workspaces Overview
hl.bind(mods.hyper .. " + CTRL + ESCAPE", hl.dsp.exec_cmd(vars.pypr .. " expose")) -- BACKSLASH

-- Minimize Workspaces
hl.bind(mods.mainMod .. " + D", hl.dsp.exec_cmd(scripts .. "/desktop"))
hl.bind(mods.mainMod .. " + M", hl.dsp.exec_cmd(vars.pypr .. " toggle_special minimized"))
hl.bind(mods.modShift .. " + M", hl.dsp.workspace.toggle_special("minimized"))

-- Special Workspace
-- hl.bind(mods.mainMod .. " + Z", hl.dsp.workspace.toggle_special("stash"))
-- hl.bind(mods.modShift .. " + Z", hl.dsp.window.move({ workspace = "special:stash", follow = false }))

-- Audio
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })

-- Volume
hl.bind(
  "XF86AudioMute",
  hl.dsp.exec_cmd(
    "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle; wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '/MUTED/ {print 0; next} {print int($2 * 100)}' > $XDG_RUNTIME_DIR/wob.sock"
  )
)
hl.bind(
  "XF86AudioRaiseVolume",
  hl.dsp.exec_cmd(
    "wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+; rmpc volume +5; wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print int($2 * 100)}' > $XDG_RUNTIME_DIR/wob.sock"
  ),
  { repeating = true, locked = true }
)
hl.bind(
  "XF86AudioLowerVolume",
  hl.dsp.exec_cmd(
    "wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%-; rmpc volume -5; wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print int($2 * 100)}' > $XDG_RUNTIME_DIR/wob.sock"
  ),
  { repeating = true, locked = true }
)

-- Microphone
hl.bind(
  "SHIFT + XF86AudioMute",
  hl.dsp.exec_cmd(
    "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle; wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | awk '/MUTED/ {print 0; next} {print int($2 * 100)}' > $XDG_RUNTIME_DIR/wob.sock"
  )
)
hl.bind(
  "SHIFT + XF86AudioRaiseVolume",
  hl.dsp.exec_cmd(
    "wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SOURCE@ 5%+; wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | awk '{print int($2 * 100)}' > $XDG_RUNTIME_DIR/wob.sock"
  ),
  { repeating = true, locked = true }
)
hl.bind(
  "SHIFT + XF86AudioLowerVolume",
  hl.dsp.exec_cmd(
    "wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SOURCE@ 5%-; wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | awk '{print int($2 * 100)}' > $XDG_RUNTIME_DIR/wob.sock"
  ),
  { repeating = true, locked = true }
)

-- Brightness
hl.bind(
  "F11",
  hl.dsp.exec_cmd(
    "CUR=$(ddcutil --bus=6 getvcp 10 | awk -F 'current value = ' '{print $2}' | awk -F, '{print $1}' | tr -d ' '); VAL=$((CUR - 5)); [ $VAL -lt 0 ]   && VAL=0;   ddcutil --bus=6 setvcp 10 $VAL & echo $VAL > $XDG_RUNTIME_DIR/wob.sock"
  ),
  { repeating = true }
)
hl.bind(
  "F12",
  hl.dsp.exec_cmd(
    "CUR=$(ddcutil --bus=6 getvcp 10 | awk -F 'current value = ' '{print $2}' | awk -F, '{print $1}' | tr -d ' '); VAL=$((CUR + 5)); [ $VAL -gt 100 ] && VAL=100; ddcutil --bus=6 setvcp 10 $VAL & echo $VAL > $XDG_RUNTIME_DIR/wob.sock"
  ),
  { repeating = true }
)

-- Zoom
hl.bind(mods.hyper .. " + CTRL + Z", hl.dsp.exec_cmd(vars.pypr .. " zoom"))
hl.bind(mods.hyper .. " + CTRL + BACKSPACE", zoom_0)

hl.bind(mods.hyper .. " + CTRL + MINUS", function() zoom(0.9) end, { repeating = true })
hl.bind(mods.hyper .. " + CTRL + EQUAL", function() zoom(1.1) end, { repeating = true })
hl.bind(mods.hyper .. " + CTRL + KP_SUBTRACT", function() zoom(0.9) end, { repeating = true })
hl.bind(mods.hyper .. " + CTRL + KP_ADD", function() zoom(1.1) end, { repeating = true })

-- █▀▄▀█ ▄▀█ █▀ ▀█▀ █▀▀ █▀█   █   ▄▀█ █▄█ █▀█ █ █ ▀█▀
-- █ ▀ █ █▀█ ▄█  █  ██▄ █▀▄   █▄▄ █▀█  █  █▄█ █▄█  █

hl.bind(mods.modCtrl .. " + EQUAL", hl.dsp.layout("addmaster"))
hl.bind(mods.modCtrl .. " + MINUS", hl.dsp.layout("removemaster"))

hl.bind(mods.modShift .. " + MINUS", hl.dsp.layout("mfact -0.05"))
hl.bind(mods.modShift .. " + EQUAL", hl.dsp.layout("mfact +0.05"))

-- █▀ █▀▀ █▀█ █▀█ █   █   █ █▄ █ █▀▀   █   ▄▀█ █▄█ █▀█ █ █ ▀█▀
-- ▄█ █▄▄ █▀▄ █▄█ █▄▄ █▄▄ █ █ ▀█ █▄█   █▄▄ █▀█  █  █▄█ █▄█  █

-- Keybinds
hl.bind(mods.modAlt .. " + P", hl.dsp.layout("promote")) -- focused window in new col
hl.bind(mods.modAlt .. " + F", hl.dsp.layout("fit active")) -- center/fit

hl.bind(mods.modAlt .. " + H", hl.dsp.layout("swapcol l"))
hl.bind(mods.modAlt .. " + L", hl.dsp.layout("swapcol r"))

-- Columns
hl.bind(mods.modAlt .. " + COMMA", hl.dsp.layout("move -col"))
hl.bind(mods.modAlt .. " + PERIOD", hl.dsp.layout("move +col"))

-- Windows
--- Moving
hl.bind(mods.modShift .. " + H", hl.dsp.window.move({ direction = "l" }))
hl.bind(mods.modShift .. " + K", hl.dsp.window.move({ direction = "u" }))
hl.bind(mods.modShift .. " + J", hl.dsp.window.move({ direction = "d" }))
hl.bind(mods.modShift .. " + L", hl.dsp.window.move({ direction = "r" }))

hl.bind(mods.modShift .. " + LEFT", hl.dsp.window.move({ direction = "l" }))
hl.bind(mods.modShift .. " + UP", hl.dsp.window.move({ direction = "u" }))
hl.bind(mods.modShift .. " + DOWN", hl.dsp.window.move({ direction = "d" }))
hl.bind(mods.modShift .. " + RIGHT", hl.dsp.window.move({ direction = "r" }))

--- Resizing
hl.bind(mods.modAlt .. " + MINUS", hl.dsp.layout("colresize -0.1"))
hl.bind(mods.modAlt .. " + EQUAL", hl.dsp.layout("colresize +0.1"))

-- █▀▄▀█ █▀█ █ █ █▀ █▀▀   █▄▄ █ █▄ █ █▀▄ █ █▄ █ █▀▀ █▀
-- █ ▀ █ █▄█ █▄█ ▄█ ██▄   █▄█ █ █ ▀█ █▄▀ █ █ ▀█ █▄█ ▄█

hl.bind(mods.mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mods.mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })
-- hl.bind(mods.mainMod .. " + mouse:274", hl.dsp.window.drag(), { mouse = true })

-- Focusing
hl.bind(mods.mainMod .. " + mouse_up", hl.dsp.focus({ direction = "l" }))
hl.bind(mods.mainMod .. " + mouse_down", hl.dsp.focus({ direction = "r" }))

-- Resize
hl.bind(mods.modCtrl .. " + mouse_up", hl.dsp.window.resize({ x = -40, y = 0, relative = true }))
hl.bind(mods.modCtrl .. " + mouse_down", hl.dsp.window.resize({ x = 40, y = 0, relative = true }))
hl.bind(mods.modShift .. " + mouse_up", hl.dsp.window.resize({ x = 0, y = -40, relative = true }))
hl.bind(mods.modShift .. " + mouse_down", hl.dsp.window.resize({ x = 0, y = 40, relative = true }))

-- Moving to Workspace
hl.bind(mods.mainMod .. " + " .. mods.hyper .. " + mouse_up", hl.dsp.focus({ workspace = "m-1" }))
hl.bind(mods.mainMod .. " + " .. mods.hyper .. " + mouse_down", hl.dsp.focus({ workspace = "m+1" }))

-- Zoom
hl.bind(mods.hyper .. " + CTRL + mouse_up", function() zoom(0.9) end)
hl.bind(mods.hyper .. " + CTRL + mouse_down", function() zoom(1.1) end)

-- █ █ █▀▄▀█
-- ▀▄▀ █ ▀ █

hl.bind("CTRL + " .. mods.modAlt .. " + P", hl.dsp.submap("passthru"))
hl.define_submap("passthru", function() hl.bind("CTRL + " .. mods.modAlt .. " + P", hl.dsp.submap("reset")) end)

-- Windows VM
hl.bind(
  mods.hyper .. " + CTRL + BACKSLASH",
  hl.dsp.exec_cmd("[float; size 60% 70%; center] " .. vars.term .. " " .. bin .. "/windows")
)

-- Windows VM Desktop
hl.bind("CTRL + " .. mods.modAlt .. " + W", hl.dsp.exec_cmd(bin .. "/windows --desktop"))
