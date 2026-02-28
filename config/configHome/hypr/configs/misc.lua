-- █▀▄▀█ █ █▀ █▀▀
-- █ ▀ █ █ ▄█ █▄▄

hl.config({
  misc = {
    anr_missed_pings = 3,
    -- disable_autoreload = true,
    disable_hyprland_logo = true,
    disable_splash_rendering = true,
    focus_on_activate = true,
    font_family = "JetBrainsMono Nerd Font",
    force_default_wallpaper = 1,
    key_press_enables_dpms = true,
    middle_click_paste = true,

    swallow_regex = "^(kitty)$",
    vrr = 3,
  },

  ecosystem = {
    no_donation_nag = true,
    no_update_news = true,
  },

  general = {
    layout = "scrolling", -- dwindle, master, monocle, scrolling
    locale = "en_US",
  },

  opengl = {
    nvidia_anti_flicker = false,
  },

  render = {
    direct_scanout = true,
  },

  xwayland = {
    force_zero_scaling = true,
  },
})
