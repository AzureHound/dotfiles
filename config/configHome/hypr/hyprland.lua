-- █ █ █▄█ █▀█ █▀█ █   ▄▀█ █▄ █ █▀▄
-- █▀█  █  █▀▀ █▀▄ █▄▄ █▀█ █ ▀█ █▄▀

local conf = os.getenv("HOME") .. "/Developer/dotfiles/config/configHome/hypr"
package.path = package.path .. ";" .. conf .. "/?.lua"

-- Configs
require("configs.autostart")
require("configs.func")
require("configs.binds")
require("configs.env")
require("configs.input")
require("configs.layouts")
require("configs.misc")
require("configs.monitors")
require("configs.plugins")
require("configs.workspaces")

-- Theme
require("theme.animations")
require("theme.decorations")
require("theme.rules")
