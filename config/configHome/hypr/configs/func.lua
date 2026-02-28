---@diagnostic disable: lowercase-global

-- Kill
function kill()
  local win = hl.get_active_window()
  if win and win.title and not win.title:match("Steam") then
    hl.dispatch(hl.dsp.window.close({ window = win }))
  end
end

-- Performance
function performance()
  if hl.get_config("animations.enabled") then
    hl.config({
      animations = { enabled = false },
      decoration = {
        shadow = { enabled = false },
        blur = { enabled = false },
        rounding = 0,
      },
      general = {
        gaps_in = 0,
        gaps_out = 0,
        border_size = 1,
        allow_tearing = true,
      },
      misc = {
        disable_hyprland_logo = true,
        disable_splash_rendering = true,
      },
    })
    -- hl.dispatch(hl.dsp.exec_cmd("swww kill"))
  else
    hl.dispatch(hl.dsp.exec_cmd("hyprctl reload"))
    -- hl.dispatch(hl.dsp.exec_cmd("swww-daemon --format xrgb >/dev/null 2>&1 &"))
  end
end

-- Zoom
function zoom(multiplier)
  local current = hl.get_config("cursor.zoom_factor")
  current = math.max(1.0, current * multiplier)
  hl.config({ cursor = { zoom_factor = current } })
end

function zoom_0() hl.config({ cursor = { zoom_factor = 1.0 } }) end
