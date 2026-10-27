-- █   █ █▀█ █▀█ █▄▀ █▀ █▀█ ▄▀█ █▀▀ █▀▀ █▀
-- █▄▀▄█ █▄█ █▀▄ █ █ ▄█ █▀▀ █▀█ █▄▄ ██▄ ▄█

for i = 1, 9 do
  local rule = { workspace = tostring(i), persistent = true }

  if i == 5 then
    rule.gaps_in = 8
    rule.gaps_out = 40
  elseif i == 7 then
    rule.layout = "monocle"
  end

  hl.workspace_rule(rule)
end

hl.workspace_rule({
  workspace = "10",
  persistent = true,
  gaps_in = 0,
  gaps_out = 0,
  no_border = true,
  decorate = false,
  no_rounding = true,
})

-- Rules
hl.workspace_rule({ workspace = "special:stash", gaps_out = 40, gaps_in = 10, border_size = 4, no_shadow = true })
hl.workspace_rule({ workspace = "special:exposed", gaps_out = 40, gaps_in = 10, border_size = 4, no_shadow = true })
hl.workspace_rule({ workspace = "special:minimized", gaps_out = 40, gaps_in = 10, border_size = 4, no_shadow = true })
