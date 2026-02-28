-- https://github.com/shezdy/hyprsplit

local hs = require("hyprsplit")

-- Conf
hs.config({
  num_workspaces = 9,
})

local super      = "SUPER"
local supershift = "SUPER SHIFT"
local superalt   = "SUPER ALT"

-- Keybinds
hl.bind(super, "1", hs.dsp.focus({ workspace = 1 }))
hl.bind(super, "2", hs.dsp.focus({ workspace = 2 }))
hl.bind(super, "3", hs.dsp.focus({ workspace = 3 }))
hl.bind(super, "4", hs.dsp.focus({ workspace = 4 }))
hl.bind(super, "5", hs.dsp.focus({ workspace = 5 }))
hl.bind(super, "6", hs.dsp.focus({ workspace = 6 }))
hl.bind(super, "7", hs.dsp.focus({ workspace = 7 }))
hl.bind(super, "8", hs.dsp.focus({ workspace = 8 }))
hl.bind(super, "9", hs.dsp.focus({ workspace = 9 }))

-- Moving windows to other workspaces
hl.bind(supershift, "1", hs.dsp.window.move({ workspace = 1, follow = true }))
hl.bind(supershift, "2", hs.dsp.window.move({ workspace = 2, follow = true }))
hl.bind(supershift, "3", hs.dsp.window.move({ workspace = 3, follow = true }))
hl.bind(supershift, "4", hs.dsp.window.move({ workspace = 4, follow = true }))
hl.bind(supershift, "5", hs.dsp.window.move({ workspace = 5, follow = true }))
hl.bind(supershift, "6", hs.dsp.window.move({ workspace = 6, follow = true }))
hl.bind(supershift, "7", hs.dsp.window.move({ workspace = 7, follow = true }))
hl.bind(supershift, "8", hs.dsp.window.move({ workspace = 8, follow = true }))
hl.bind(supershift, "9", hs.dsp.window.move({ workspace = 9, follow = true }))

-- Moving windows to other workspaces (silent)
hl.bind(superalt, "1", hs.dsp.window.move({ workspace = 1, follow = false }))
hl.bind(superalt, "2", hs.dsp.window.move({ workspace = 2, follow = false }))
hl.bind(superalt, "3", hs.dsp.window.move({ workspace = 3, follow = false }))
hl.bind(superalt, "4", hs.dsp.window.move({ workspace = 4, follow = false }))
hl.bind(superalt, "5", hs.dsp.window.move({ workspace = 5, follow = false }))
hl.bind(superalt, "6", hs.dsp.window.move({ workspace = 6, follow = false }))
hl.bind(superalt, "7", hs.dsp.window.move({ workspace = 7, follow = false }))
hl.bind(superalt, "8", hs.dsp.window.move({ workspace = 8, follow = false }))
hl.bind(superalt, "9", hs.dsp.window.move({ workspace = 9, follow = false }))
