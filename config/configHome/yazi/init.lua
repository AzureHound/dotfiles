local catppuccin = {
  rosewater = "#f4dbd6",
  flamingo = "#f0c6c6",
  pink = "#f5bde6",
  mauve = "#c6a0f6",
  red = "#ed8796",
  maroon = "#ee99a0",
  peach = "#f5a97f",
  yellow = "#eed49f",
  green = "#a6da95",
  teal = "#8bd5ca",
  sky = "#91d7e3",
  sapphire = "#7dc4e4",
  blue = "#8aadf4",
  lavender = "#b7bdf8",
  text = "#cad3f5",
  subtext1 = "#b8c0e0",
  subtext0 = "#a5adcb",
  overlay2 = "#939ab7",
  overlay1 = "#8087a2",
  overlay0 = "#6e738d",
  surface2 = "#5b6078",
  surface1 = "#494d64",
  surface0 = "#363a4f",
  base = "#24273a",
  mantle = "#1e2030",
  crust = "#181926",
}

-- eza
require("eza-preview"):setup({
  default_tree = true,
  level = 3,
  follow_symlinks = true,
  dereference = true,
  all = true,
})

-- full-border
require("full-border"):setup({
  type = ui.Border.ROUNDED,
})

-- git
require("git"):setup()

-- gvfs
require("gvfs"):setup({})

-- searchjump
require("searchjump"):setup({
  unmatch_fg = catppuccin.overlay0,
  match_str_fg = catppuccin.peach,
  match_str_bg = catppuccin.base,
  first_match_str_fg = catppuccin.lavender,
  first_match_str_bg = catppuccin.base,
  lable_fg = catppuccin.green,
  lable_bg = catppuccin.base,
  only_current = false, -- only search the current window
  show_search_in_statusbar = false,
  auto_exit_when_unmatch = false,
  enable_capital_lable = false,
  search_patterns = {}, -- demo:{"%.e%d+","s%d+e%d+"}
})

-- yatline
require("yatline"):setup({
  section_separator = { open = "", close = "" },
  inverse_separator = { open = "", close = "" },
  part_separator = { open = "|", close = "|" },

  style_a = {
    fg = catppuccin.mantle,
    bg_mode = {
      normal = catppuccin.blue,
      select = catppuccin.mauve,
      un_set = catppuccin.red,
    },
  },
  style_b = { bg = catppuccin.surface0, fg = catppuccin.text },
  style_c = { bg = catppuccin.base, fg = catppuccin.text },

  permissions_t_fg = catppuccin.green,
  permissions_r_fg = catppuccin.yellow,
  permissions_w_fg = catppuccin.red,
  permissions_x_fg = catppuccin.sky,
  permissions_s_fg = catppuccin.lavender,

  selected = { icon = "󰻭", fg = catppuccin.yellow },
  copied = { icon = "", fg = catppuccin.green },
  cut = { icon = "", fg = catppuccin.red },

  total = { icon = "", fg = catppuccin.yellow },
  succ = { icon = "", fg = catppuccin.green },
  fail = { icon = "", fg = catppuccin.red },
  found = { icon = "", fg = catppuccin.blue },
  processed = { icon = "", fg = catppuccin.green },

  tab_width = 20,
  tab_use_inverse = true,

  show_background = false,

  display_header_line = true,
  display_status_line = true,

  header_line = {
    left = {
      section_a = {
        { type = "line", custom = false, name = "tabs", params = { "left" } },
      },
      section_b = {
        { type = "coloreds", custom = false, name = "githead" },
      },
      section_c = {},
    },
    right = {
      section_a = {
        { type = "string", custom = false, name = "tab_path" },
      },
      section_b = {
        { type = "coloreds", custom = false, name = "task_workload" },
      },
      section_c = {
        { type = "coloreds", custom = false, name = "task_states" },
      },
    },
  },

  status_line = {
    left = {
      section_a = {
        { type = "string", custom = false, name = "tab_mode" },
      },
      section_b = {
        { type = "string", custom = false, name = "hovered_size" },
      },
      section_c = {
        { type = "string", custom = false, name = "hovered_name" },
        { type = "coloreds", custom = false, name = "count" },
      },
    },
    right = {
      section_a = {
        { type = "string", custom = false, name = "cursor_position" },
      },
      section_b = {
        { type = "string", custom = false, name = "cursor_percentage" },
      },
      section_c = {
        { type = "string", custom = false, name = "hovered_file_extension", params = { true } },
        { type = "coloreds", custom = false, name = "permissions" },
      },
    },
  },
})

-- yatline-githead
require("yatline-githead"):setup({
  show_branch = true,
  branch_prefix = "",
  branch_symbol = "",
  branch_borders = "",

  commit_symbol = " ",

  show_behind_ahead = true,
  behind_symbol = " ",
  ahead_symbol = " ",

  show_stashes = true,
  stashes_symbol = " ",

  show_state = true,
  show_state_prefix = true,
  state_symbol = "󱅉",

  show_staged = true,
  staged_symbol = " ",

  show_unstaged = true,
  unstaged_symbol = " ",

  show_untracked = true,
  untracked_symbol = " ",

  prefix_color = catppuccin.pink,
  branch_color = catppuccin.pink,
  commit_color = catppuccin.mauve,
  stashes_color = catppuccin.teal,
  state_color = catppuccin.lavender,
  staged_color = catppuccin.green,
  unstaged_color = catppuccin.yellow,
  untracked_color = catppuccin.pink,
})

-- zoxide
require("zoxide"):setup({
  update_db = true,
})

-- Functions
function Linemode:size_and_mtime()
  local time = math.floor(self._file.cha.mtime or 0)
  if time == 0 then
    time = ""
  elseif os.date("%Y", time) == os.date("%Y") then
    time = os.date("%b %d %H:%M", time)
  else
    time = os.date("%b %d  %Y", time)
  end

  local size = self._file:size()
  return string.format("%s %s", size and ya.readable_size(size) or "-", time)
end
