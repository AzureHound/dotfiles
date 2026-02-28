-- ▄▀█ █▄ █ █ █▀▄▀█ ▄▀█ ▀█▀ █ █▀█ █▄ █ █▀
-- █▀█ █ ▀█ █ █ ▀ █ █▀█  █  █ █▄█ █ ▀█ ▄█

hl.config({
  animations = {
    enabled = true,
  },
})

-- stylua: ignore start

-- █▄▄ █▀▀ ▀█ █ █▀▀ █▀█
-- █▄█ ██▄ █▄ █ ██▄ █▀▄

hl.curve("easeOutQuint",   { type = "bezier", points = { { 0.23, 1 },    { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear",         { type = "bezier", points = { { 0, 0 },       { 1, 1 } } })
hl.curve("almostLinear",   { type = "bezier", points = { { 0.5, 0.5 },   { 0.75, 1 } } })
hl.curve("quick",          { type = "bezier", points = { { 0.15, 0 },    { 0.1, 1 } } })

-- ▄▀█ █▄ █ █ █▀▄▀█ ▄▀█ ▀█▀ █ █▀█ █▄ █
-- █▀█ █ ▀█ █ █ ▀ █ █▀█  █  █ █▄█ █ ▀█

hl.animation({ leaf = "windowsIn",           enabled = true, speed = 3, bezier = "easeOutQuint", style = "slide" })
hl.animation({ leaf = "windowsOut",          enabled = true, speed = 3, bezier = "easeOutQuint", style = "slide" })
hl.animation({ leaf = "windowsMove",         enabled = true, speed = 5, bezier = "easeOutQuint", style = "slide" })

hl.animation({ leaf = "layersIn",            enabled = true, speed = 3, bezier = "easeOutQuint", style = "slide" })
hl.animation({ leaf = "layersOut",           enabled = true, speed = 3, bezier = "easeOutQuint", style = "slide" })

hl.animation({ leaf = "fadeIn",              enabled = true, speed = 1, bezier = "quick" })
hl.animation({ leaf = "fadeOut",             enabled = true, speed = 1, bezier = "quick" })

hl.animation({ leaf = "fadeSwitch",          enabled = true, speed = 4, bezier = "default" })
hl.animation({ leaf = "fadeShadow",          enabled = true, speed = 4, bezier = "default" })
hl.animation({ leaf = "fadeDim",             enabled = true, speed = 4, bezier = "default" })

hl.animation({ leaf = "fadeLayersIn",        enabled = true, speed = 2, bezier = "linear" })
hl.animation({ leaf = "fadeLayersOut",       enabled = true, speed = 2, bezier = "linear" })

hl.animation({ leaf = "fadePopupsIn",        enabled = true, speed = 2, bezier = "linear" })
hl.animation({ leaf = "fadePopupsOut",       enabled = true, speed = 2, bezier = "linear" })

hl.animation({ leaf = "fadeDpms",            enabled = true, speed = 2, bezier = "linear" })

hl.animation({ leaf = "border",              enabled = true, speed = 1, bezier = "linear" })
-- hl.animation({ leaf = "borderangle",         enabled = true, speed = 50, bezier = "linear", style = "loop" })

hl.animation({ leaf = "workspacesIn",        enabled = true, speed = 4, bezier = "easeOutQuint", style = "slide" })
hl.animation({ leaf = "workspacesOut",       enabled = true, speed = 4, bezier = "easeOutQuint", style = "slide" })

hl.animation({ leaf = "specialWorkspaceIn",  enabled = true, speed = 6, bezier = "easeOutQuint", style = "slidefadevert -50%" })
hl.animation({ leaf = "specialWorkspaceOut", enabled = true, speed = 6, bezier = "easeOutQuint", style = "slidefadevert -50%" })

hl.animation({ leaf = "zoomFactor",          enabled = true, speed = 7, bezier = "quick" })
