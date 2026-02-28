-- █   █ █▀█ █▀█ █▄▀ █▀ █▀█ ▄▀█ █▀▀ █▀▀ █▀
-- █▄▀▄█ █▄█ █▀▄ █ █ ▄█ █▀▀ █▀█ █▄▄ ██▄ ▄█

hl.workspace_rule({ workspace = "1",  persistent = true })
hl.workspace_rule({ workspace = "2",  persistent = true })
hl.workspace_rule({ workspace = "3",  persistent = true })
hl.workspace_rule({ workspace = "4",  persistent = true })
hl.workspace_rule({ workspace = "5",  persistent = true, gaps_in = 8, gaps_out = 40 })
hl.workspace_rule({ workspace = "6",  persistent = true })
hl.workspace_rule({ workspace = "7",  persistent = true })
hl.workspace_rule({ workspace = "8",  persistent = true })
hl.workspace_rule({ workspace = "9",  persistent = true })
hl.workspace_rule({ workspace = "10", persistent = true, gaps_in = 0, gaps_out = 0, no_border = true, decorate = false, no_rounding = true })

-- Rules
hl.workspace_rule({ workspace = "special:stash",     gaps_out = 40, gaps_in = 10, border_size = 4, no_shadow = true })
hl.workspace_rule({ workspace = "special:exposed",   gaps_out = 40, gaps_in = 10, border_size = 4, no_shadow = true })
hl.workspace_rule({ workspace = "special:minimized", gaps_out = 40, gaps_in = 10, border_size = 4, no_shadow = true })
