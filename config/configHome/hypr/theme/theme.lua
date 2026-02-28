-- ▀█▀ █ █ █▀▀ █▀▄▀█ █▀▀
--  █  █▀█ ██▄ █ ▀ █ ██▄

local conf = os.getenv("HOME") .. "/Developer/dotfiles/config/configHome/hypr"

dofile(conf .. "/theme/colors.lua")
dofile(conf .. "/theme/animations.lua")
dofile(conf .. "/theme/decorations.lua")
dofile(conf .. "/theme/rules.lua")
