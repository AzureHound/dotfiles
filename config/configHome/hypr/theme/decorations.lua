-- █▀▀ █▀▀ █▄ █ █▀▀ █▀█ ▄▀█ █
-- █▄█ ██▄ █ ▀█ ██▄ █▀▄ █▀█ █▄▄

hl.config({
  general = {
    gaps_in = 4,
    gaps_out = 10,
    -- gaps_workspaces = 0,

    border_size = 2,
    resize_on_border = true,

    col = {
      active_border = "rgba(" .. colors.lavenderAlpha .. "80)",
      inactive_border = "rgba(" .. colors.textAlpha .. "40)",

      -- active_border = {
      --   colors = {
      --     "rgba(" .. colors.textAlpha .. "ee)",
      --     "rgba(" .. colors.lavenderAlpha .. "69)",
      --   },
      --   angle = 45,
      -- },
      -- inactive_border = "rgba(" .. colors.lavenderAlpha .. "69)",

      nogroup_border = "rgba(" .. colors.lavenderAlpha .. "80)",
      nogroup_border_active = "rgba(" .. colors.textAlpha .. "40)",
    },

    snap = {
      enabled = true,
      window_gap = 20,
    },
  },

  -- █▀▄ █▀▀ █▀▀ █▀█ █▀█ ▄▀█ ▀█▀ █ █▀█ █▄ █
  -- █▄▀ ██▄ █▄▄ █▄█ █▀▄ █▀█  █  █ █▄█ █ ▀█

  decoration = {
    rounding = 6,

    active_opacity = 0.92,
    inactive_opacity = 0.90,

    dim_inactive = true,
    dim_strength = 0.05,
    dim_special = 0.7,
    dim_around = 1.0,

    blur = {
      size = 9,
      passes = 2,
      noise = 0.0,
    },

    shadow = {
      enabled = false,
      scale = 2,
      range = 26,
      render_power = 5,
      color = colors.surface0,
      color_inactive = colors.crust,
    },
  },

  -- █▀▀ █ █ █▀█ █▀ █▀█ █▀█
  -- █▄▄ █▄█ █▀▄ ▄█ █▄█ █▀▄

  cursor = {
    hide_on_key_press = true,
    inactive_timeout = 20,

    no_hardware_cursors = true,
    no_warps = true,
    persistent_warps = true,
  },

  -- █▀▀ █▀█ █▀█ █ █ █▀█
  -- █▄█ █▀▄ █▄█ █▄█ █▀▀

  group = {
    -- stylua: ignore
    col = {
      border_active = {
        colors = {
          "rgba(" .. colors.textAlpha .. "ee)",
          "rgba(" .. colors.lavenderAlpha .. "69)",
          "rgba(" .. colors.lavenderAlpha .. "69)",
          "rgba(" .. colors.textAlpha .. "ee)"
        },
        angle = 45
      },
      border_inactive = "rgba(" .. colors.lavenderAlpha .. "69)",

      border_locked_active = {
        colors = {
          "rgba(" .. colors.textAlpha .. "ee)",
          "rgba(" .. colors.lavenderAlpha .. "69)",
          "rgba(" .. colors.lavenderAlpha .. "69)",
          "rgba(" .. colors.textAlpha .. "ee)"
        },
        angle = 45
      },
      border_locked_inactive = "rgba(" .. colors.lavenderAlpha .. "69)",
    },

    groupbar = {
      blur = true,
      gaps_in = 4,
      gaps_out = 4,
      gradients = true,
      gradient_rounding = 7,

      col = {
        active = "rgba(" .. colors.lavenderAlpha .. "cc)",
        inactive = "rgba(" .. colors.overlay2Alpha .. "99)",
        locked_active = "rgba(" .. colors.maroonAlpha .. "cc)",
        locked_inactive = "rgba(" .. colors.subtext1Alpha .. "99)",
      },

      font_family = "JetBrainsMono Nerd Font",
      font_size = 15,
      text_color = colors.crust,
      text_color_inactive = colors.mantle,
      height = 20,
      indicator_height = 0,
    },
  },
})
