{ lib, pkgs, ... }:

{
  plugins.snacks = {
    enable = true;

    settings = {
      animate = {
        fps = 60;
      };
      dashboard = {
        enabled = true;
        sections = [
          { section = "header"; }
          {
            section = "keys";
            gap = 1;
            padding = 1;
          }
          # { section = "startup" }
        ];
        preset = {
          header = ''
                                                                                 
                  ████ ██████           █████     ██                      
                 ███████████             █████                             
                 █████████ ███████████████████ ███   ███████████   
                █████████  ███    █████████████ █████ ██████████████   
               █████████ ██████████ █████████ █████ █████ ████ █████   
             ███████████ ███    ███ █████████ █████ █████ ████ █████  
            ██████  █████████████████████ ████ █████ █████ ████ ██████ 
          '';
          keys = [
            {
              icon = " ";
              key = "f";
              desc = "Find File";
              action = ":lua Snacks.dashboard.pick('files')";
            }
            {
              icon = "󱉯 ";
              key = "g";
              desc = "Find Text";
              action = ":lua Snacks.dashboard.pick('live_grep')";
            }
            {
              icon = " ";
              key = "r";
              desc = "Recent Files";
              action = ":lua Snacks.dashboard.pick('oldfiles')";
            }
            {
              icon = " ";
              key = "p";
              desc = "Projects/Repos";
              action = ":lua Snacks.dashboard.pick('projects')";
            }
            {
              icon = " ";
              key = "z";
              desc = "Zoxide";
              action = ":lua Snacks.picker.zoxide()";
            }
            {
              icon = " ";
              key = "c";
              desc = "Config";
              action = ":lua Snacks.dashboard.pick('files', {cwd = '~/Developer/dotfiles/home/' .. vim.env.USER .. '/nixvim'})";
            }
            {
              icon = "󰛢 ";
              key = "e";
              desc = "Harpoon";
              action.__raw = "function() require('harpoon').ui:toggle_quick_menu(require('harpoon'):list()) end";
            }
            {
              icon = " ";
              key = "s";
              desc = "Restore Session";
              section = "session";
            }
            {
              icon = "󰗚 ";
              key = "h";
              desc = "Help Pages";
              action = ":lua Snacks.picker.help()";
            }
            {
              icon = " ";
              key = "q";
              desc = "Quit";
              action = ":qa";
            }
          ];
        };
      };
      dim = {
        scope = {
          min_size = 5;
          max_size = 20;
          siblings = true;
        };
        animate = {
          enabled.__raw = "vim.fn.has('nvim-0.10') == 1";
          easing = "outQuad";
          duration = {
            step = 20;
            total = 300;
          };
        };
      };
      explorer = {
        enabled = true;
        replace_netrw = true;
        trash = true;
      };
      files = {
        finder = "files";
        format = "file";
        show_empty = true;
        hidden = true;
        ignored = false;
        follow = true;
        supports_live = true;
      };
      git.enabled = true;
      gh = { };
      image = {
        enabled = true;
        doc = {
          float = true;
          inline = false;
          max_width = 50;
          max_height = 30;
          wo.wrap = false;
        };
        convert = {
          notify = true;
          command = "magick";
        };
        img_dirs = [
          "img"
          "images"
          "assets"
          "static"
          "public"
          "media"
          "attachments"
          "~/Obsidian/Imgs"
          "~/Downloads"
          "~/Pictures"
        ];
      };
      indent = {
        enabled = true;
        char = "│";
        only_scope = false;
      };
      input.enabled = true;
      lazygit = {
        enabled = true;
        configure = false;
        win = {
          keys = {
            q = "close";
          };
        };
      };
      notifier = {
        enabled = true;
        timeout = 3000;
      };
      picker = {
        ui_select = true;
        previewers.git.builtin = false;
        matcher = {
          frecency = false;
          cwd_bonus = true;
        };
        formatters.file = {
          filename_first = false;
          filename_only = false;
          icon_width = 2;
        };
        sources.explorer = {
          auto_close = true;
          follow_file = true;
          tree = true;
          watch = false;
          focus = "list";
          jump.close = false;
          win.list.keys."." = "explorer_focus";
          layout = {
            layout = {
              position = "right";
              cycle = false;
            };
          };
        };
      };
      scope.enabled = true;
      scroll.enabled = true;
      statuscolumn.enabled = true;
      styles.notification.wo.wrap = true;
      styles.terminal = {
        position = "float";
        backdrop = 60;
        width = 0.9;
        height = 0.9;
        border = "rounded";
        row = 2;
      };
      terminal = {
        enabled = true;
        win.keys = lib.mkForce { "<c-/>" = "hide"; };
      };
      words.enabled = true;
    };
  };

  keymaps = [
    # pickers & explorer
    {
      mode = "n";
      key = "<leader>fz";
      action.__raw = "function() Snacks.picker.smart() end";
      options.desc = "Smart Find Files";
    }
    {
      mode = "n";
      key = "<leader><leader>";
      action.__raw = "function() Snacks.picker.buffers() end";
      options.desc = "Buffers";
    }
    {
      mode = "n";
      key = "<leader>/";
      action.__raw = "function() Snacks.picker.grep() end";
      options.desc = "Grep";
    }
    {
      mode = "n";
      key = "<leader>fZ";
      action.__raw = "function() Snacks.picker.zoxide() end";
      options.desc = "Zoxide";
    }
    {
      mode = "n";
      key = "<leader>:";
      action.__raw = "function() Snacks.picker.command_history() end";
      options.desc = "Command History";
    }
    {
      mode = "n";
      key = "<leader>n";
      action.__raw = "function() Snacks.notifier.show_history() end";
      options.desc = "Notification History";
    }
    {
      mode = "n";
      key = "<leader>e";
      action.__raw = "function() Snacks.explorer() end";
      options.desc = "File Explorer";
    }

    # find
    {
      mode = "n";
      key = "<leader>fc";
      action.__raw = "function() Snacks.picker.files({ cwd = '~/Developer/dotfiles/home/' .. vim.env.USER .. '/nixvim' }) end";
      options.desc = "Find Config File";
    }
    {
      mode = "n";
      key = "-";
      action.__raw = "function() Snacks.picker.files() end";
      options.desc = "Find Files";
    }
    {
      mode = "n";
      key = "<leader>fg";
      action.__raw = "function() Snacks.picker.git_files() end";
      options.desc = "Find Git Files";
    }
    {
      mode = "n";
      key = "<leader>fp";
      action.__raw = "function() Snacks.picker.projects() end";
      options.desc = "Projects";
    }
    {
      mode = "n";
      key = "<leader>fr";
      action.__raw = "function() Snacks.picker.recent() end";
      options.desc = "Recent";
    }

    # git
    {
      mode = "n";
      key = "<leader>gb";
      action.__raw = "function() Snacks.picker.git_branches() end";
      options.desc = "Git Branches";
    }
    {
      mode = "n";
      key = "<leader>gl";
      action.__raw = "function() Snacks.picker.git_log() end";
      options.desc = "Git Log";
    }
    {
      mode = "n";
      key = "<leader>gL";
      action.__raw = "function() Snacks.picker.git_log_line() end";
      options.desc = "Git Log Line";
    }
    {
      mode = "n";
      key = "<leader>gs";
      action.__raw = "function() Snacks.picker.git_status() end";
      options.desc = "Git Status";
    }
    {
      mode = "n";
      key = "<leader>gS";
      action.__raw = "function() Snacks.picker.git_stash() end";
      options.desc = "Git Stash";
    }
    {
      mode = "n";
      key = "<leader>gd";
      action.__raw = "function() Snacks.picker.git_diff() end";
      options.desc = "Git Diff (Hunks)";
    }
    {
      mode = "n";
      key = "<leader>gf";
      action.__raw = "function() Snacks.picker.git_log_file() end";
      options.desc = "Git Log File";
    }
    {
      mode = [
        "n"
        "v"
        "x"
      ];
      key = "<leader>gB";
      action.__raw = "function() Snacks.gitbrowse() end";
      options.desc = "Git Browse (open)";
    }
    {
      mode = [
        "n"
        "x"
      ];
      key = "<leader>gY";
      action.__raw = "function() Snacks.gitbrowse({ open = function(url) vim.fn.setreg('+', url) end, notify = false }) end";
      options.desc = "Git Browse (copy)";
    }

    # lazygit
    {
      mode = "n";
      key = "<leader>gg";
      action.__raw = "function() Snacks.lazygit() end";
      options.desc = "Lazygit (Root Dir)";
    }
    {
      mode = "n";
      key = "<leader>lg";
      action.__raw = "function() Snacks.lazygit({ cwd = vim.uv.cwd() }) end";
      options.desc = "Lazygit (cwd)";
    }

    # gh
    {
      mode = "n";
      key = "<leader>gi";
      action.__raw = "function() Snacks.picker.gh_issue() end";
      options.desc = "GitHub Issues (open)";
    }
    {
      mode = "n";
      key = "<leader>gI";
      action.__raw = "function() Snacks.picker.gh_issue({ state = 'all' }) end";
      options.desc = "GitHub Issues (all)";
    }
    {
      mode = "n";
      key = "<leader>gp";
      action.__raw = "function() Snacks.picker.gh_pr() end";
      options.desc = "GitHub Pull Requests (open)";
    }
    {
      mode = "n";
      key = "<leader>gP";
      action.__raw = "function() Snacks.picker.gh_pr({ state = 'all' }) end";
      options.desc = "GitHub Pull Requests (all)";
    }

    # grep
    {
      mode = "n";
      key = "<leader>sb";
      action.__raw = "function() Snacks.picker.lines() end";
      options.desc = "Buffer Lines";
    }
    {
      mode = "n";
      key = "<leader>sB";
      action.__raw = "function() Snacks.picker.grep_buffers() end";
      options.desc = "Grep Open Buffers";
    }
    # { mode = "n"; key = "<leader>sg"; action.__raw = "function() Snacks.picker.grep() end"; options.desc = "Grep"; }
    {
      mode = [
        "n"
        "x"
      ];
      key = "<leader>sw";
      action.__raw = "function() Snacks.picker.grep_word() end";
      options.desc = "Visual selection or word";
    }

    # search
    {
      mode = "n";
      key = "<leader>s\"";
      action.__raw = "function() Snacks.picker.registers() end";
      options.desc = "Registers";
    }
    {
      mode = "n";
      key = "<leader>s/";
      action.__raw = "function() Snacks.picker.search_history() end";
      options.desc = "Search History";
    }
    {
      mode = "n";
      key = "<leader>sa";
      action.__raw = "function() Snacks.picker.autocmds() end";
      options.desc = "Autocmds";
    }
    {
      mode = "n";
      key = "<leader>sC";
      action.__raw = "function() Snacks.picker.commands() end";
      options.desc = "Commands";
    }
    {
      mode = "n";
      key = "<leader>sd";
      action.__raw = "function() Snacks.picker.diagnostics() end";
      options.desc = "Diagnostics";
    }
    {
      mode = "n";
      key = "<leader>sD";
      action.__raw = "function() Snacks.picker.diagnostics_buffer() end";
      options.desc = "Buffer Diagnostics";
    }
    {
      mode = "n";
      key = "<leader>sh";
      action.__raw = "function() Snacks.picker.help() end";
      options.desc = "Help Pages";
    }
    {
      mode = "n";
      key = "<leader>sH";
      action.__raw = "function() Snacks.picker.highlights() end";
      options.desc = "Highlights";
    }
    {
      mode = "n";
      key = "<leader>si";
      action.__raw = "function() Snacks.picker.icons() end";
      options.desc = "Icons";
    }
    {
      mode = "n";
      key = "<leader>sj";
      action.__raw = "function() Snacks.picker.jumps() end";
      options.desc = "Jumps";
    }
    {
      mode = "n";
      key = "<leader>sk";
      action.__raw = "function() Snacks.picker.keymaps() end";
      options.desc = "Keymaps";
    }
    {
      mode = "n";
      key = "<leader>sl";
      action.__raw = "function() Snacks.picker.loclist() end";
      options.desc = "Location List";
    }
    {
      mode = "n";
      key = "<leader>sm";
      action.__raw = "function() Snacks.picker.marks() end";
      options.desc = "Marks";
    }
    {
      mode = "n";
      key = "<leader>sM";
      action.__raw = "function() Snacks.picker.man() end";
      options.desc = "Man Pages";
    }
    {
      mode = "n";
      key = "<leader>sq";
      action.__raw = "function() Snacks.picker.qflist() end";
      options.desc = "Quickfix List";
    }
    {
      mode = "n";
      key = "<leader>sR";
      action.__raw = "function() Snacks.picker.resume() end";
      options.desc = "Resume";
    }
    {
      mode = "n";
      key = "<leader>su";
      action.__raw = "function() Snacks.picker.undo() end";
      options.desc = "Undo History";
    }
    {
      mode = "n";
      key = "<leader>uC";
      action.__raw = "function() Snacks.picker.colorschemes() end";
      options.desc = "Colorschemes";
    }

    # lsp
    {
      mode = "n";
      key = "gd";
      action.__raw = "function() Snacks.picker.lsp_definitions() end";
      options.desc = "Goto Definition";
    }
    {
      mode = "n";
      key = "gD";
      action.__raw = "function() Snacks.picker.lsp_declarations() end";
      options.desc = "Goto Declaration";
    }
    {
      mode = "n";
      key = "gr";
      action.__raw = "function() Snacks.picker.lsp_references() end";
      options = {
        nowait = true;
        desc = "References";
      };
    }
    {
      mode = "n";
      key = "gI";
      action.__raw = "function() Snacks.picker.lsp_implementations() end";
      options.desc = "Goto Implementation";
    }
    {
      mode = "n";
      key = "gy";
      action.__raw = "function() Snacks.picker.lsp_type_definitions() end";
      options.desc = "Goto T[y]pe Definition";
    }
    {
      mode = "n";
      key = "<leader>ss";
      action.__raw = "function() Snacks.picker.lsp_symbols() end";
      options.desc = "LSP Symbols";
    }
    {
      mode = "n";
      key = "<leader>sS";
      action.__raw = "function() Snacks.picker.lsp_workspace_symbols() end";
      options.desc = "LSP Workspace Symbols";
    }

    # dashboard
    {
      mode = "n";
      key = "<leader>fd";
      action.__raw = "function() Snacks.dashboard() end";
      options.desc = "Dashboard";
    }

    # buffers
    {
      mode = "n";
      key = "<leader>bd";
      action.__raw = "function() Snacks.bufdelete() end";
      options.desc = "Delete Buffer";
    }
    {
      mode = "n";
      key = "<leader>bo";
      action.__raw = "function() Snacks.bufdelete.other() end";
      options.desc = "Delete Other Buffers";
    }

    # term
    {
      mode = [
        "n"
        "t"
      ];
      key = "<leader>ft";
      action.__raw = "function() Snacks.terminal.toggle(nil, { cwd = vim.fn.expand('~'), id = 'float_home' }) end";
      options.desc = "Term";
    }
    {
      mode = [
        "n"
        "t"
      ];
      key = "<leader>fT";
      action.__raw = "function() Snacks.terminal.toggle(nil, { cwd = vim.fn.expand('%:p:h'), id = 'float_cwd' }) end";
      options.desc = "Term [cwd]";
    }

    # misc
    {
      mode = "n";
      key = "<leader>uf";
      action.__raw = "function() Snacks.toggle.format():toggle() end";
      options.desc = "Toggle Format";
    }
    {
      mode = "n";
      key = "<leader>uF";
      action.__raw = "function() Snacks.toggle.format(true):toggle() end";
      options.desc = "Toggle Format [Global]";
    }
    {
      mode = "n";
      key = "<leader>us";
      action.__raw = "function() Snacks.toggle.option('spell', { name = 'Spelling' }):toggle() end";
      options.desc = "Toggle Spelling";
    }
    {
      mode = "n";
      key = "<leader>uw";
      action.__raw = "function() Snacks.toggle.option('wrap', { name = 'Wrap' }):toggle() end";
      options.desc = "Toggle Word Wrap";
    }
    {
      mode = "n";
      key = "<leader>uL";
      action.__raw = "function() Snacks.toggle.option('relativenumber', { name = 'Relative Number' }):toggle() end";
      options.desc = "Toggle Relative Line Numbers";
    }
    {
      mode = "n";
      key = "<leader>ud";
      action.__raw = "function() Snacks.toggle.diagnostics():toggle() end";
      options.desc = "Toggle Diagnostics";
    }
    {
      mode = "n";
      key = "<leader>ul";
      action.__raw = "function() Snacks.toggle.line_number():toggle() end";
      options.desc = "Toggle Line Numbers";
    }
    {
      mode = "n";
      key = "<leader>uc";
      action.__raw = "function() Snacks.toggle.option('conceallevel', { off = 0, on = 2, name = 'Conceal Level' }):toggle() end";
      options.desc = "Toggle Conceal Level";
    }
    {
      mode = "n";
      key = "<leader>uA";
      action.__raw = "function() Snacks.toggle.option('showtabline', { off = 0, on = 2, name = 'Tabline' }):toggle() end";
      options.desc = "Toggle Tabline";
    }
    {
      mode = "n";
      key = "<leader>uT";
      action.__raw = "function() Snacks.toggle.treesitter():toggle() end";
      options.desc = "Toggle Treesitter Highlight";
    }
    # { mode = "n"; key = "<leader>ub"; action.__raw = "function() Snacks.toggle.option('background', { off = 'light', on = 'dark' , name = 'Dark Background' }):toggle() end"; options.desc = "Toggle Background"; }
    {
      mode = "n";
      key = "<leader>uD";
      action.__raw = "function() Snacks.toggle.dim():toggle() end";
      options.desc = "Toggle Dim";
    }
    {
      mode = "n";
      key = "<leader>ua";
      action.__raw = "function() Snacks.toggle.animate():toggle() end";
      options.desc = "Toggle Animations";
    }
    {
      mode = "n";
      key = "<leader>ug";
      action.__raw = "function() Snacks.toggle.indent():toggle() end";
      options.desc = "Toggle Indent Guides";
    }
    {
      mode = "n";
      key = "<leader>uS";
      action.__raw = "function() Snacks.toggle.scroll():toggle() end";
      options.desc = "Toggle Scrollbar";
    }
    {
      mode = "n";
      key = "<leader>uh";
      action.__raw = "function() Snacks.toggle.inlay_hints():toggle() end";
      options.desc = "Toggle Inlay Hints";
    }
    {
      mode = "n";
      key = "<leader>un";
      action.__raw = "function() Snacks.notifier.hide() end";
      options.desc = "Dismiss All Notifications";
    }
    {
      mode = "n";
      key = "<leader>z";
      action.__raw = "function() Snacks.zen() end";
      options.desc = "Toggle Zen Mode";
    }
    {
      mode = "n";
      key = "<leader>Z";
      action.__raw = "function() Snacks.zen.zoom() end";
      options.desc = "Toggle Zoom";
    }
    {
      mode = "n";
      key = "<leader>.";
      action.__raw = "function() Snacks.scratch() end";
      options.desc = "Toggle Scratch Buffer";
    }
    {
      mode = "n";
      key = "<leader>S";
      action.__raw = "function() Snacks.scratch.select() end";
      options.desc = "Select Scratch Buffer";
    }
    {
      mode = "n";
      key = "<leader>cR";
      action.__raw = "function() Snacks.rename.rename_file() end";
      options.desc = "Rename File";
    }
    {
      mode = "n";
      key = "<leader>N";
      action.__raw = "function() Snacks.win({ file = vim.api.nvim_get_runtime_file('doc/news.txt', false)[1], width = 0.6, height = 0.6, wo = { spell = false, wrap = false, signcolumn = 'yes', statuscolumn = ' ', conceallevel = 3 } }) end";
      options.desc = "Neovim News";
    }
    {
      mode = [
        "n"
        "t"
      ];
      key = "]]";
      action.__raw = "function() Snacks.words.jump(vim.v.count1) end";
      options.desc = "Next Reference";
    }
    {
      mode = [
        "n"
        "t"
      ];
      key = "[[";
      action.__raw = "function() Snacks.words.jump(-vim.v.count1) end";
      options.desc = "Prev Reference";
    }
  ];

  extraConfigLua = ''
    -- Debug
    _G.dd = function(...) Snacks.debug.inspect(...) end
    _G.bt = function() Snacks.debug.backtrace() end
    vim.print = _G.dd

    -- sqlite
    vim.g.sqlite_clib_path = "${pkgs.sqlite.out}/lib/libsqlite3.so"
  '';

  extraPackages = with pkgs; [
    dwt1-shell-color-scripts
    ghostscript_headless
    imagemagick
    lazygit
    mermaid-cli
    sqlite
    tectonic
  ];
}
