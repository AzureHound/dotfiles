{
  plugins.obsidian = {
    enable = true;
    lazyLoad.settings = {
      event = [
        { __raw = ''"BufReadPre " .. vim.fn.expand("~") .. "/Obsidian/**.md"''; }
        { __raw = ''"BufNewFile " .. vim.fn.expand("~") .. "/Obsidian/**.md"''; }
      ];
      cmd = [
        "Obsidian"
      ];
    };

    settings = {
      workspaces = [
        {
          name = "Personal";
          path = "~/Obsidian/Personal";
        }
        {
          name = "Professional";
          path = "~/Obsidian";
        }
      ];
      notes_subdir = "Notes";
      new_notes_location = "notes_subdir";
      daily_notes.folder = "Notes/Dailies";
      attachments.folder = "Assets/imgs";
      templates.folder = "Templates";

      ui.enable = false;
      picker.name = "snacks.pick";
      legacy_commands = false;

      # Logic Functions
      note_id_func.__raw = ''
        function(title)
          if title == nil or title == "" then
            return os.date("%Y-%m-%d %H:%M:%S")
          else
            return title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
          end
        end
      '';

      note_path_func.__raw = ''
        function(spec)
          local path = spec.dir / tostring(spec.id)
          return path:with_suffix(".md")
        end
      '';

      frontmatter.func.__raw = ''
        function(note)
          if note.title then
            note:add_alias(note.title)
          end
          local out = { aliases = note.aliases }
          if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
            for k, v in pairs(note.metadata) do
              out[k] = v
            end
          end
          return out
        end
      '';

      callbacks.enter_note.__raw = ''
        function(client, note)
          if not note or not note.bufnr then return end

          -- gf for Obsidian follow link
          vim.keymap.set("n", "gf", "<cmd>Obsidian follow_link<cr>", {
            buffer = note.bufnr,
            desc = "File Passthrough",
          })

          -- PDF and Image override
          vim.ui.open = (function(overridden)
            return function(uri, opt)
              if vim.endswith(uri, ".png") then
                vim.cmd("edit " .. uri)
                return
              elseif vim.endswith(uri, ".pdf") then
                opt = { cmd = { "zathura" } }
              end
              return overridden(uri, opt)
            end
          end)(vim.ui.open)
        end
      '';

      image.resolve.__raw = ''
        function(path, src)
          if require("obsidian.api").path_is_note(path) then
            return require("obsidian.api").resolve_image_path(src)
          end
        end
      '';
    };
  };

  # Which-key
  plugins.which-key.settings.spec = [
    {
      __unkeyed-1 = "<leader>o";
      group = "obsidian";
      icon = " ";
      mode = [
        "n"
        "v"
      ];
    }
  ];

  keymaps = [
    # Normal mode
    {
      mode = "n";
      key = "<leader>oo";
      action = "<cmd>Obsidian open<CR>";
      options.desc = "Open on App";
    }
    {
      mode = "n";
      key = "<leader>og";
      action = "<cmd>Obsidian search<CR>";
      options.desc = "Grep";
    }
    {
      mode = "n";
      key = "<leader>on";
      action = "<cmd>Obsidian new<CR>";
      options.desc = "New Note";
    }
    {
      mode = "n";
      key = "<leader>oN";
      action = "<cmd>Obsidian new_from_template<CR>";
      options.desc = "New Note (Template)";
    }
    {
      mode = "n";
      key = "<leader>o<space>";
      action = "<cmd>Obsidian quick_switch<CR>";
      options.desc = "Find Files";
    }
    {
      mode = "n";
      key = "<leader>ob";
      action = "<cmd>Obsidian backlinks<CR>";
      options.desc = "Backlinks";
    }
    {
      mode = "n";
      key = "<leader>ot";
      action = "<cmd>Obsidian tags<CR>";
      options.desc = "Tags";
    }
    {
      mode = "n";
      key = "<leader>oT";
      action = "<cmd>Obsidian template<CR>";
      options.desc = "Template";
    }
    {
      mode = "n";
      key = "<leader>ol";
      action = "<cmd>Obsidian links<CR>";
      options.desc = "Links";
    }
    {
      mode = "n";
      key = "<leader>ow";
      action = "<cmd>Obsidian workspace<CR>";
      options.desc = "Workspace";
    }
    {
      mode = "n";
      key = "<leader>or";
      action = "<cmd>Obsidian rename<CR>";
      options.desc = "Rename";
    }
    {
      mode = "n";
      key = "<leader>oi";
      action = "<cmd>Obsidian paste_img<CR>";
      options.desc = "Paste Image";
    }
    {
      mode = "n";
      key = "<leader>od";
      action = "<cmd>Obsidian dailies<CR>";
      options.desc = "Daily Notes";
    }

    # Visual mode
    {
      mode = "v";
      key = "<leader>oL";
      action = "<cmd>Obsidian link<CR>";
      options.desc = "Link";
    }
    {
      mode = "v";
      key = "<leader>ol";
      action = "<cmd>Obsidian link_new<CR>";
      options.desc = "New Link";
    }
    {
      mode = "v";
      key = "<leader>oe";
      action = "<cmd>Obsidian extract_note<CR>";
      options.desc = "Extract Note";
    }

    # Snacks Tasks
    {
      mode = "n";
      key = "<leader>ok";
      action.__raw = ''
        function()
          Snacks.picker.grep({
            search = "^\\\\s*- \\\\[ \\\\]",
            regex = true,
            dirs = { vim.fn.getcwd() },
            finder = "grep",
            format = "file",
            show_empty = true,
            supports_live = false,
            live = false,
          })
        end
      '';
      options.desc = "Tasks [Unfinished]";
    }
    {
      mode = "n";
      key = "<leader>oK";
      action.__raw = ''
        function()
          Snacks.picker.grep({
            search = "^\\\\s*- \\\\[x\\\\]:",
            regex = true,
            dirs = { vim.fn.getcwd() },
            finder = "grep",
            format = "file",
            show_empty = true,
            supports_live = false,
            live = false,
          })
        end
      '';
      options.desc = "Tasks [Finished]";
    }
  ];
}
