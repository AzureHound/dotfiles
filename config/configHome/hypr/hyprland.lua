-- █ █ █▄█ █▀█ █▀█ █   ▄▀█ █▄ █ █▀▄
-- █▀█  █  █▀▀ █▀▄ █▄▄ █▀█ █ ▀█ █▄▀

local conf = os.getenv("HOME") .. "/Developer/dotfiles/config/configHome/hypr"

-- Monitors
---@diagnostic disable: undefined-global
for _, m in ipairs(monitors) do
  hl.monitor({
    output = m.output,
    mode = m.mode,
    position = m.position,
    scale = m.scale,
  })
end

-- PERF: Don't run on single monitor
if #monitors > 1 then
  local per_mon = math.floor(10 / #monitors)
  for ws = 1, 10 do
    local idx = math.min(math.floor((ws - 1) / per_mon), #monitors - 1)
    hl.workspace_rule({
      workspace = tostring(ws),
      monitor = monitors[idx + 1].output,
      default = ws == 1 or nil,
    })
  end
end

-- Configs
dofile(conf .. "/configs/apps.lua")
dofile(conf .. "/configs/func.lua")
dofile(conf .. "/configs/binds.lua")
dofile(conf .. "/configs/env.lua")
dofile(conf .. "/configs/input.lua")
dofile(conf .. "/configs/layouts.lua")
dofile(conf .. "/configs/misc.lua")
-- dofile(conf .. "/configs/monitors.lua")
dofile(conf .. "/configs/plugins.lua")
dofile(conf .. "/configs/workspaces.lua")
dofile(conf .. "/theme/theme.lua")

-- Autostart
hl.on("hyprland.start", function()
  local autostart = conf .. "/scripts/autostart/"
  hl.exec_cmd(autostart .. "apps")
  hl.exec_cmd(autostart .. "services")
end)
