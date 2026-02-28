{ pkgs, ... }:

{
  plugins = {
    treesitter = {
      enable = true;
      nixvimInjections = true;

      # grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [ ];

      settings = {
        highlight.enable = true;
        indent.enable = true;
        incremental_selection = {
          enable = true;
          keymaps = {
            init_selection = "<C-space>";
            node_incremental = "<C-space>";
            scope_incremental = false;
            node_decremental = "<bs>";
          };
        };
        query_linter = {
          enable = true;
          use_virtual_text = true;
          lint_events = [
            "BufWrite"
            "CursorHold"
          ];
        };
      };
    };

    treesitter-context = {
      enable = false;
      lazyLoad.settings.event = [
        "BufReadPost"
        "BufNewFile"
      ];

      settings.max_lines = 3;
    };

    treesitter-textobjects = {
      enable = true;
      settings = {
        move = {
          enable = true;
          set_jumps = true;
          goto_next_start = {
            "]f" = {
              query = "@function.outer";
              desc = "Next Function Start";
            };
            "]c" = {
              query = "@class.outer";
              desc = "Next Class Start";
            };
            "]a" = {
              query = "@parameter.inner";
              desc = "Next Parameter Start";
            };
          };
          goto_next_end = {
            "]F" = {
              query = "@function.outer";
              desc = "Next Function End";
            };
            "]C" = {
              query = "@class.outer";
              desc = "Next Class End";
            };
            "]A" = {
              query = "@parameter.inner";
              desc = "Next Parameter End";
            };
          };
          goto_previous_start = {
            "[f" = {
              query = "@function.outer";
              desc = "Prev Function Start";
            };
            "[c" = {
              query = "@class.outer";
              desc = "Prev Class Start";
            };
            "[a" = {
              query = "@parameter.inner";
              desc = "Prev Parameter Start";
            };
          };
          goto_previous_end = {
            "[F" = {
              query = "@function.outer";
              desc = "Prev Function End";
            };
            "[C" = {
              query = "@class.outer";
              desc = "Prev Class End";
            };
            "[A" = {
              query = "@parameter.inner";
              desc = "Prev Parameter End";
            };
          };
        };
      };
    };

    ts-autotag = {
      enable = true;
      lazyLoad.settings.event = [ "InsertEnter" ];
    };
  };

  filetype = {
    extension = {
      rasi = "rasi";
      rofi = "rasi";
      wofi = "rasi";
    };
    filename = {
      vifmrc = "vim";
    };
    pattern = {
      ".*/mako/config" = "dosini";
      ".*/waybar/config" = "jsonc";
    };
  };

  extraConfigLua = ''
    local parsers = require("nvim-treesitter.parsers")

    vim.api.nvim_set_hl(0, "TreesitterContextBottom", { underline = true, sp = "Grey" })

    vim.api.nvim_create_autocmd("FileType", {
      group = vim.api.nvim_create_augroup("nvim_treesitter_folds", { clear = true }),
      callback = function(ev)
        if pcall(vim.treesitter.get_parser, ev.buf) then
          vim.wo.foldmethod = "expr"
          vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
        end
      end,
    })
  '';

  keymaps = [
    {
      mode = "n";
      key = "[c";
      action.__raw = "function() require('treesitter-context').go_to_context(vim.v.count1) end";
      options = {
        silent = true;
        desc = "Jump to Context";
      };
    }
    {
      mode = "n";
      key = "<leader>ut";
      action.__raw = ''
        function()
          local tsc = require("treesitter-context")
          Snacks.toggle({
            name = "Treesitter Context",
            get = tsc.enabled,
            set = function(state)
              if state then tsc.enable() else tsc.disable() end
            end,
          }):map("<leader>ut")
        end
      '';
      options.desc = "Toggle Context";
    }
  ];

  extraPackages = with pkgs; [ tree-sitter ];
}
