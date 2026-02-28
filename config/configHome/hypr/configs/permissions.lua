-- █▀█ █▀▀ █▀█ █▀▄▀█ █ █▀ █▀ █ █▀█ █▄ █ █▀
-- █▀▀ ██▄ █▀▄ █ ▀ █ █ ▄█ ▄█ █ █▄█ █ ▀█ ▄█

hl.config({
  ecosystem = {
    enforce_permissions = false,
  },

  -- Allow
  permission = {
    ".*/bin/grim, screencopy, allow",
    ".*/bin/hyprlock, screencopy, allow",
    ".*/bin/hyprpicker, screencopy, allow",
    ".*/bin/hyprpm, plugin, allow",
    ".*/bin/satty, screencopy, allow",
    ".*/bin/slurp, screencopy, allow",
    ".*/bin/quickshell, screencopy, allow",
    ".*/bin/gpu-screen-recorder, screencopy, allow",
    ".*/libexec/xdg-desktop-portal-hyprland, screencopy, allow",

    -- Deny
    ".*, keyboard, deny",
  },
})
