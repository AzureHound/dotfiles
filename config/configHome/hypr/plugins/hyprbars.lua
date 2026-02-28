local home = os.getenv("HOME")
dofile(home .. "/Developer/dotfiles/config/hypr/theme/colors.lua")

-- Conf
hl.config({
  plugin = {
    hyprbars = {
      bar_blur = true,
      bar_height = 30,
      bar_color = colors.mantle,

      bar_title_enabled = true,
      bar_text_font = "JetBrainsMono Nerd Font",
      bar_text_size = 12,

      bar_text_align = "center",
      bar_buttons_alignment = "left",

      bar_padding = 10,
      bar_button_padding = 7,

      bar_part_of_window = true,
      bar_precedence_over_border = false,

      icon_on_hover = true,
      ["col.text"] = colors.subtext0,
      inactive_button_color = colors.surface0,

      on_double_click = "hyprctl dispatch fullscreen 1",
    },
  },
})

hl.plugin.hyprbars.add_button({
  bg_color = "rgb(ed8796)",
  size = 15,
  icon = "󰖭",
  action = "hyprctl dispatch killactive",
})

hl.plugin.hyprbars.add_button({
  bg_color = "rgb(eed49f)",
  size = 15,
  icon = "",
  action = 'hyprctl dispatch exec "pypr toggle_special minimized"',
})

hl.plugin.hyprbars.add_button({
  bg_color = "rgb(a6da95)",
  size = 15,
  icon = "󱓼",
  action = "hyprctl dispatch fullscreen 1",
})
