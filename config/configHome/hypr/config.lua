-- Monitors
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
      workspace = ws,
      monitor = monitors[idx + 1].output,
      default = ws == 1 or nil,
    })
  end
end

dofile(os.getenv("HOME") .. "/Developer/dotfiles/config/configHome/hypr/hyprland.lua")
