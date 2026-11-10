-- https://github.com/shezdy/hyprsplit

local hs = require("hyprsplit")

-- Conf
hs.config({
  num_workspaces = 9,
})

local meta = "SUPER"

-- Keybinds
hl.bind(meta, "1", hs.dsp.focus({ workspace = 1 }))
hl.bind(meta, "2", hs.dsp.focus({ workspace = 2 }))
hl.bind(meta, "3", hs.dsp.focus({ workspace = 3 }))
hl.bind(meta, "4", hs.dsp.focus({ workspace = 4 }))
hl.bind(meta, "5", hs.dsp.focus({ workspace = 5 }))
hl.bind(meta, "6", hs.dsp.focus({ workspace = 6 }))
hl.bind(meta, "7", hs.dsp.focus({ workspace = 7 }))
hl.bind(meta, "8", hs.dsp.focus({ workspace = 8 }))
hl.bind(meta, "9", hs.dsp.focus({ workspace = 9 }))

-- Moving windows to other workspaces
hl.bind(meta .. " SHIFT", "1", hs.dsp.window.move({ workspace = 1, follow = true }))
hl.bind(meta .. " SHIFT", "2", hs.dsp.window.move({ workspace = 2, follow = true }))
hl.bind(meta .. " SHIFT", "3", hs.dsp.window.move({ workspace = 3, follow = true }))
hl.bind(meta .. " SHIFT", "4", hs.dsp.window.move({ workspace = 4, follow = true }))
hl.bind(meta .. " SHIFT", "5", hs.dsp.window.move({ workspace = 5, follow = true }))
hl.bind(meta .. " SHIFT", "6", hs.dsp.window.move({ workspace = 6, follow = true }))
hl.bind(meta .. " SHIFT", "7", hs.dsp.window.move({ workspace = 7, follow = true }))
hl.bind(meta .. " SHIFT", "8", hs.dsp.window.move({ workspace = 8, follow = true }))
hl.bind(meta .. " SHIFT", "9", hs.dsp.window.move({ workspace = 9, follow = true }))

-- Moving windows to other workspaces (silent)
hl.bind(meta .. " ALT", "1", hs.dsp.window.move({ workspace = 1, follow = false }))
hl.bind(meta .. " ALT", "2", hs.dsp.window.move({ workspace = 2, follow = false }))
hl.bind(meta .. " ALT", "3", hs.dsp.window.move({ workspace = 3, follow = false }))
hl.bind(meta .. " ALT", "4", hs.dsp.window.move({ workspace = 4, follow = false }))
hl.bind(meta .. " ALT", "5", hs.dsp.window.move({ workspace = 5, follow = false }))
hl.bind(meta .. " ALT", "6", hs.dsp.window.move({ workspace = 6, follow = false }))
hl.bind(meta .. " ALT", "7", hs.dsp.window.move({ workspace = 7, follow = false }))
hl.bind(meta .. " ALT", "8", hs.dsp.window.move({ workspace = 8, follow = false }))
hl.bind(meta .. " ALT", "9", hs.dsp.window.move({ workspace = 9, follow = false }))
