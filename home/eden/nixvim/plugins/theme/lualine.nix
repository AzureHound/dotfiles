{
  plugins.lualine = {
    enable = true;

    settings = {
      options = {
        theme = "auto";
        globalstatus = true;
        component_separators = {
          left = "|";
          right = "|";
        };
        section_separators = {
          left = "";
          right = "";
        };
        disabled_filetypes.statusline = [
          "dashboard"
          "ministarter"
          "snacks_dashboard"
          "snacks_terminal"
        ];
        extensions = [ "fzf" ];
      };

      sections = {
        lualine_a = [
          {
            __unkeyed-1 = "mode";
            icon = "";
          }
        ];

        lualine_b = [
          # git icon
          {
            __unkeyed-1.__raw = ''
              function()
                local branch = vim.b.gitsigns_head or vim.fn.FugitiveHead()
                if not branch or branch == "" then
                  _G.git_remote_data = nil
                  return ""
                end

                if not _G.git_remote_data then
                  _G.git_remote_data = { icon = " ", color = "#a6da95" }
                  local remote_name = vim.fn.system("git config branch." .. branch .. ".remote"):gsub("%s+", "")

                  if remote_name ~= "" then
                    local url = vim.fn.system("git config remote." .. remote_name .. ".url"):gsub("%s+", "")
                    if url ~= "" then
                      if url:match("github%.com") or remote_name == "github" then _G.git_remote_data = { icon = " ", color = "#a5adcb" }
                      elseif url:match("gitlab") or remote_name == "gitlab" then _G.git_remote_data = { icon = " ", color = "#f5a97f" }
                      elseif url:match("forgejo") or remote_name == "forgejo" then _G.git_remote_data = { icon = " ", color = "#ee99a0" }
                      elseif url:match("codeberg") or remote_name == "codeberg" then _G.git_remote_data = { icon = " ", color = "#8aadf4" }
                      end
                    end
                  end
                end
                return _G.git_remote_data.icon
              end
            '';
            color.__raw = ''function() return { fg = _G.git_remote_data and _G.git_remote_data.color or "#a6da95" } end'';
            padding = {
              left = 1;
              right = 0;
            };
            separator = "";
          }
          # git branch
          {
            __unkeyed-1.__raw = "function() return vim.b.gitsigns_head or vim.fn.FugitiveHead() or '' end";
            color = {
              fg = "#a6da95";
            };
            padding = {
              left = 0;
              right = 1;
            };
          }
        ];

        lualine_c = [
          { __raw = "root_dir()"; }
          {
            __unkeyed-1 = "diagnostics";
            symbols = {
              error.__raw = "vim.g.icons.diagnostics.Error";
              warn.__raw = "vim.g.icons.diagnostics.Warn";
              info.__raw = "vim.g.icons.diagnostics.Info";
              hint.__raw = "vim.g.icons.diagnostics.Hint";
            };
          }
          {
            __unkeyed-1 = "filetype";
            icon_only = true;
            separator = "";
            padding = {
              left = 1;
              right = 0;
            };
          }
          { __raw = "pretty_path()"; }
        ];

        lualine_x = [
          # Obsidian Workspace
          {
            __unkeyed-1.__raw = ''
              function()
                if vim.bo.filetype ~= "markdown" then return "" end
                local obs = _G.Obsidian
                if not (obs and obs.opts and obs.opts.workspaces) then return "" end
                local path = vim.api.nvim_buf_get_name(0)
                for _, w in ipairs(obs.opts.workspaces) do
                  if path:find(vim.fn.expand(w.path), 1, true) then
                    return "󱓧"
                  end
                end
                return ""
              end
            '';
            color = {
              fg = "#c6a0f6";
            };
            padding = {
              left = 1;
              right = 0;
            };
            separator = "";
          }
          {
            __unkeyed-1.__raw = ''
              function()
                if vim.bo.filetype ~= "markdown" then return "" end
                local obs = _G.Obsidian
                if not (obs and obs.opts and obs.opts.workspaces) then return "" end
                local path = vim.api.nvim_buf_get_name(0)
                for _, w in ipairs(obs.opts.workspaces) do
                  if path:find(vim.fn.expand(w.path), 1, true) then
                    return w.name
                  end
                end
                return ""
              end
            '';
            color = {
              fg = "#a5adcb";
            };
            padding = {
              left = 1;
              right = 1;
            };
          }
          # Noice Stat
          {
            __unkeyed-1.__raw = ''function() return require("noice").api.status.command.get() end'';
            cond.__raw = ''function() return package.loaded["noice"] and require("noice").api.status.command.has() end'';
            color.__raw = ''function() return { fg = Snacks.util.color("Statement") } end'';
          }
          # DAP Stat
          {
            __unkeyed-1.__raw = ''function() return "  " .. (package.loaded["dap"] and require("dap").status() or "") end'';
            cond.__raw = ''function() return package.loaded["dap"] and require("dap").status() ~= "" end'';
            color.__raw = ''function() return { fg = Snacks.util.color("Debug") } end'';
          }
          # Formatter Icon [Conform]
          {
            __unkeyed-1.__raw = ''
              function()
                local formatters = package.loaded["conform"] and require("conform").list_formatters(0) or {}
                return #formatters > 0 and "󰛖 " or ""
              end
            '';
          }
          # Linter Icon
          {
            __unkeyed-1.__raw = ''
              function()
                local linters = package.loaded["lint"] and require("lint").linters_by_ft[vim.bo.filetype] or {}
                return #linters > 0 and "󱉶 " or ""
              end
            '';
          }
          # Diff
          {
            __unkeyed-1 = "diff";
            symbols = {
              added.__raw = "vim.g.icons.git.added";
              modified.__raw = "vim.g.icons.git.modified";
              removed.__raw = "vim.g.icons.git.removed";
            };
          }
          # OS
          # { __unkeyed-1 = "fileformat"; }
        ];

        lualine_y = [ "progress" ];
        lualine_z = [
          {
            __unkeyed-1 = "location";
            padding = {
              left = 1;
              right = 0;
            };
          }
          {
            __unkeyed-1.__raw = "function() return '󰦨' end";
            padding = {
              left = 0;
              right = 1;
            };
          }
        ];
      };
    };
  };

  extraConfigLuaPre = ''
    require("lualine_require").require = require

    -- Formatting
    function lualine_format(component, text, hl_group)
      if not hl_group or hl_group == "" then return text end
      component.hl_cache = component.hl_cache or {}
      if not component.hl_cache[hl_group] then
        local utils = require("lualine.utils.utils")
        local gui = vim.tbl_filter(function(x) return x end, {
          utils.extract_highlight_colors(hl_group, "bold") and "bold",
          utils.extract_highlight_colors(hl_group, "italic") and "italic",
        })
        component.hl_cache[hl_group] = component:create_hl({
          fg = utils.extract_highlight_colors(hl_group, "fg"),
          gui = #gui > 0 and table.concat(gui, ",") or nil,
        }, "X_" .. hl_group)
      end
      return component:format_hl(component.hl_cache[hl_group]) .. text .. component:get_default_hl()
    end

    -- Stat
    function lualine_status(icon, status)
      local colors = { ok = "Special", error = "DiagnosticError", pending = "DiagnosticWarn" }
      return {
        function() return icon end,
        cond = function() return status() ~= nil end,
        color = function()
          return { fg = require("snacks").util.color(colors[status()] or colors.ok) }
        end,
      }
    end

    -- Cmp
    function lualine_cmp_source(name, icon)
      local started = false
      return lualine_status(icon, function()
        if not package.loaded["cmp"] then return end
        for _, s in ipairs(require("cmp").core.sources or {}) do
          if s.name == name then
            if s.source:is_available() then
              started = true
            else
              return started and "error" or nil
            end
            return s.status == s.SourceStatus.FETCHING and "pending" or "ok"
          end
        end
      end)
    end

    -- Root Directory
    function root_dir(opts)
      opts = vim.tbl_extend("force", {
        cwd = false, subdirectory = true, parent = true, other = true, icon = "󱉭 ",
        color = function() return { fg = require("snacks").util.color("Special") } end,
      }, opts or {})

      local function get_name()
        local cwd, root = vim.uv.cwd(), root_get()
        local name = vim.fs.basename(root)
        if root == cwd then return opts.cwd and name
        elseif root:find(cwd, 1, true) == 1 then return opts.subdirectory and name
        elseif cwd:find(root, 1, true) == 1 then return opts.parent and name
        else return opts.other and name end
      end

      return {
        function() return (opts.icon and opts.icon .. " ") .. get_name() end,
        cond = function() return type(get_name()) == "string" end,
        color = opts.color,
      }
    end

    -- Pretty Path
    function pretty_path(opts)
      opts = vim.tbl_extend("force", {
        relative = "cwd",
        modified_hl = "MatchParen",
        directory_hl = "",
        filename_hl = "Bold",
        modified_sign = "",
        readonly_icon = " 󰌾 ",
        length = 3,
      }, opts or {})

      return {
        function(self)
          local path = vim.fn.expand("%:p")
          if path == "" then return "" end
          path = vim.fs.normalize(path)
          local root, cwd = root_get(), vim.uv.cwd()

          if opts.relative == "cwd" and path:find(cwd, 1, true) == 1 then
            path = path:sub(#cwd + 2)
          elseif path:find(root, 1, true) == 1 then
            path = path:sub(#root + 2)
          end

          local sep = package.config:sub(1, 1)
          local parts = vim.split(path, "[\\/]")
          if opts.length > 0 and #parts > opts.length then
            parts = { parts[1], "…", unpack(parts, #parts - opts.length + 2, #parts) }
          end

          if opts.modified_hl and vim.bo.modified then
            parts[#parts] = lualine_format(self, parts[#parts] .. opts.modified_sign, opts.modified_hl)
          else
            parts[#parts] = lualine_format(self, parts[#parts], opts.filename_hl)
          end

          local dir = ""
          if #parts > 1 then
            dir = lualine_format(self, table.concat({ unpack(parts, 1, #parts - 1) }, sep) .. sep, opts.directory_hl)
          end
          return dir .. parts[#parts] .. (vim.bo.readonly and lualine_format(self, opts.readonly_icon, opts.modified_hl) or "")
        end
      }
    end
  '';

  extraConfigLua = ''
    vim.api.nvim_create_autocmd("VimEnter", {
      callback = function()
        vim.opt.laststatus = 0
      end,
    })
  '';

  keymaps = [
    {
      mode = "n";
      key = "<leader>ll";
      action.__raw = "function() if vim.opt.laststatus:get() == 0 then vim.opt.laststatus = 3 else vim.opt.laststatus = 0 end end";
      options.desc = "Toggle Statusline";
    }
  ];
}
