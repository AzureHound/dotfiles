{
  extraConfigLuaPre = ''
    _G.Mini = {}

    -- Autopairs
    function Mini.pairs(opts)
      local pairs = require("mini.pairs")
      local open = pairs.open
      pairs.open = function(pair, neigh)
        if vim.fn.getcmdline() ~= "" then return open(pair, neigh) end
        local o, c = pair:sub(1, 1), pair:sub(2, 2)
        local line = vim.api.nvim_get_current_line()
        local col = vim.api.nvim_win_get_cursor(0)[2]
        local next = line:sub(col + 1, col + 1)
        if opts.markdown and o == "`" and vim.bo.filetype == "markdown" and line:sub(1, col):match("^%s*``") then
          return "`\n```" .. vim.api.nvim_replace_termcodes("<up>", true, true, true)
        end
        if opts.skip_next and next ~= "" and next:match(opts.skip_next) then return o end
        if opts.skip_unbalanced and next == c and c ~= o then
          local _, count_o = line:gsub(vim.pesc(o), "")
          local _, count_c = line:gsub(vim.pesc(c), "")
          if count_c > count_o then return o end
        end
        return open(pair, neigh)
      end
    end

    -- Which-key
    function Mini.ai_whichkey(opts)
      local objects = {
        { " ", desc = "whitespace" }, { '"', desc = '" string' }, { "'", desc = "' string" },
        { "(", desc = "() block" }, { ")", desc = "() block with ws" }, { "<", desc = "<> block" },
        { ">", desc = "<> block with ws" }, { "?", desc = "user prompt" }, { "U", desc = "use/call without dot" },
        { "[", desc = "[] block" }, { "]", desc = "[] block with ws" }, { "_", desc = "underscore" },
        { "`", desc = "` string" }, { "a", desc = "argument" }, { "b", desc = ")]} block" },
        { "c", desc = "class" }, { "d", desc = "digit(s)" }, { "e", desc = "CamelCase / snake_case" },
        { "f", desc = "function" }, { "g", desc = "entire file" }, { "i", desc = "indent" },
        { "o", desc = "block, conditional, loop" }, { "q", desc = "quote" }, { "t", desc = "tag" },
        { "u", desc = "use/call" }, { "{", desc = "{} block" }, { "}", desc = "{} with ws" },
      }
      local ret = { mode = { "o", "x" } }
      local mappings = vim.tbl_extend("force", { around = "a", inside = "i" }, opts.mappings or {})
      for _, prefix in pairs(mappings) do
        for _, obj in ipairs(objects) do
          ret[#ret + 1] = { prefix .. obj[1], desc = obj.desc }
        end
      end
      require("which-key").add(ret)
    end
  '';

  plugins.mini = {
    enable = true;
    modules = {

      # Extends the a & i text objects
      ai = {
        n_lines = 500;
        custom_textobjects = {
          o = {
            __raw = "require('mini.ai').gen_spec.treesitter({ a = { '@block.outer', '@conditional.outer', '@loop.outer' }, i = { '@block.inner', '@conditional.inner', '@loop.inner' } })";
          };
          f = {
            __raw = "require('mini.ai').gen_spec.treesitter({ a = '@function.outer', i = '@function.inner' })";
          };
          c = {
            __raw = "require('mini.ai').gen_spec.treesitter({ a = '@class.outer', i = '@class.inner' })";
          };
          t = [
            "<([%p%w]-)%f[^<%w][^<>]->.-</%1>"
            "^<.->().*()</[^/]->$"
          ];
          d = [ "%f[%d]%d+" ];
          e = [
            [
              "%u[%l%d]+%f[^%l%d]"
              "%f[%S][%l%d]+%f[^%l%d]"
              "%f[%P][%l%d]+%f[^%l%d]"
              "^[%l%d]+%f[^%l%d]"
            ]
            "^().*()$"
          ];
          u = {
            __raw = "require('mini.ai').gen_spec.function_call()";
          };
          U = {
            __raw = "require('mini.ai').gen_spec.function_call({ name_pattern = '[%w_]' })";
          };
          g = {
            a = [ "^().*()$" ];
            i = [ "^().*()$" ];
          };
        };
      };

      hipatterns = {
        highlighters = {
          hex_color.__raw = "require('mini.hipatterns').gen_highlighter.hex_color({ priority = 2000 })";
          shorthand = {
            pattern = "()#%x%x%x()%f[^%x%w]";
            group.__raw = ''
              function(_, _, data)
                local match = data.full_match
                local r, g, b = match:sub(2, 2), match:sub(3, 3), match:sub(4, 4)
                local hex_color = "#" .. r .. r .. g .. g .. b .. b
                return MiniHipatterns.compute_hex_color_group(hex_color, "bg")
              end
            '';
            extmark_opts = {
              priority = 2000;
            };
          };
        };
      };

      pairs = {
        modes = {
          insert = true;
          command = true;
          terminal = false;
        };
      };
    };
  };

  extraConfigLua = ''
    Mini.pairs({
      skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
      skip_unbalanced = true,
      markdown = true,
    })

    if pcall(require, "which-key") then
      Mini.ai_whichkey({})
    end
  '';
}
