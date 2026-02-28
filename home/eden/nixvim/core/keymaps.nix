{
  keymaps = [
    # indenting
    {
      mode = "x";
      key = "<";
      action = "<gv";
    }
    {
      mode = "x";
      key = ">";
      action = ">gv";
    }

    # increment/decrement
    {
      mode = "n";
      key = "<M-=>";
      action = "<C-a>";
      options.desc = "Increment number";
    }
    {
      mode = "n";
      key = "<M-->";
      action = "<C-x>";
      options.desc = "Decrement number";
    }

    # commenting
    {
      mode = "n";
      key = "gco";
      action = "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>";
      options.desc = "Add Comment Below";
    }
    {
      mode = "n";
      key = "gcO";
      action = "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>";
      options.desc = "Add Comment Above";
    }

    # select
    {
      mode = "n";
      key = "<C-a>";
      action = "gg<S-v>G";
    }

    # undo break-points
    {
      mode = "i";
      key = ",";
      action = ",<c-g>u";
    }
    {
      mode = "i";
      key = ".";
      action = ".<c-g>u";
    }
    {
      mode = "i";
      key = ";";
      action = ";<c-g>u";
    }

    # delete
    {
      mode = [
        "n"
        "v"
      ];
      key = "d";
      action = "\"_d";
      options.desc = "Delete without copying";
    }
    {
      mode = "n";
      key = "dd";
      action = "\"_dd";
      options.desc = "Delete line without copying";
    }

    # paste options
    {
      mode = "v";
      key = "p";
      action = "\"_dP";
      options.desc = "Paste Without Overwriting";
    }

    # new file
    {
      mode = "n";
      key = "<leader>fn";
      action = "<cmd>enew<cr>";
      options.desc = "New File";
    }

    # formatting
    {
      mode = [
        "n"
        "x"
      ];
      key = "<leader>cf";
      action.__raw = "function() require('conform').format({ lsp_fallback = true }) end";
      options.desc = "Format";
    }

    # save without formatting
    {
      mode = [
        "n"
        "i"
        "v"
      ];
      key = "<leader>Cf";
      action = "<cmd>noautocmd w<cr>";
      options.desc = "Save [No Format]";
    }

    # save file
    {
      mode = [
        "n"
        "i"
      ];
      key = "<C-s>";
      action.__raw = ''function() vim.cmd("stopinsert") vim.cmd("noautocmd w") require("fidget").notify(vim.fn.expand("%:~"), nil, { key = "save", ttl = 2.0 }) end'';
      options = {
        desc = "Save File";
        silent = true;
      };
    }

    # https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
    {
      mode = "n";
      key = "n";
      action = "'Nn'[v:searchforward].'zv'";
      options = {
        expr = true;
        desc = "Next Search Result";
      };
    }
    {
      mode = "x";
      key = "n";
      action = "'Nn'[v:searchforward]";
      options = {
        expr = true;
        desc = "Next Search Result";
      };
    }
    {
      mode = "o";
      key = "n";
      action = "'Nn'[v:searchforward]";
      options = {
        expr = true;
        desc = "Next Search Result";
      };
    }
    {
      mode = "n";
      key = "N";
      action = "'nN'[v:searchforward].'zv'";
      options = {
        expr = true;
        desc = "Prev Search Result";
      };
    }
    {
      mode = "x";
      key = "N";
      action = "'nN'[v:searchforward]";
      options = {
        expr = true;
        desc = "Prev Search Result";
      };
    }
    {
      mode = "o";
      key = "N";
      action = "'nN'[v:searchforward]";
      options = {
        expr = true;
        desc = "Prev Search Result";
      };
    }

    # clear search & stop snippet on ESC
    {
      mode = [
        "i"
        "n"
        "s"
      ];
      key = "<esc>";
      action.__raw = ''
        function()
          vim.cmd("noh")
          if package.loaded["cmp"] then require("cmp").abort() end
          return "<esc>"
        end
      '';
      options = {
        expr = true;
        desc = "Escape and Clear hlsearch";
      };
    }

    # clear search, diff update & redraw
    {
      mode = "n";
      key = "<leader>ur";
      action = "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>";
      options.desc = "Redraw / Clear hlsearch / Diff Update";
    }

    # keywordprg
    {
      mode = "n";
      key = "<leader>K";
      action = "<cmd>norm! K<cr>";
      options.desc = "Keywordprg";
    }

    # spelling
    {
      mode = "n";
      key = "<leader>!";
      action = "zg";
      options.desc = "Add Word to Dictionary";
    }
    {
      mode = "n";
      key = "<leader>@";
      action = "zug";
      options.desc = "Remove Word from Dictionary";
    }

    # diagnostic
    {
      mode = "n";
      key = "<leader>cd";
      action.__raw = "vim.diagnostic.open_float";
      options.desc = "Line Diagnostics";
    }
    {
      mode = "n";
      key = "]d";
      action.__raw = "function() vim.diagnostic.jump({ count = vim.v.count1, float = true }) end";
      options.desc = "Next Diagnostic";
    }
    {
      mode = "n";
      key = "[d";
      action.__raw = "function() vim.diagnostic.jump({ count = -vim.v.count1, float = true }) end";
      options.desc = "Prev Diagnostic";
    }
    {
      mode = "n";
      key = "]e";
      action.__raw = "function() vim.diagnostic.jump({ count = vim.v.count1, severity = vim.diagnostic.severity.ERROR, float = true }) end";
      options.desc = "Next Error";
    }
    {
      mode = "n";
      key = "[e";
      action.__raw = "function() vim.diagnostic.jump({ count = -vim.v.count1, severity = vim.diagnostic.severity.ERROR, float = true }) end";
      options.desc = "Prev Error";
    }
    {
      mode = "n";
      key = "]w";
      action.__raw = "function() vim.diagnostic.jump({ count = vim.v.count1, severity = vim.diagnostic.severity.WARN, float = true }) end";
      options.desc = "Next Warning";
    }
    {
      mode = "n";
      key = "[w";
      action.__raw = "function() vim.diagnostic.jump({ count = -vim.v.count1, severity = vim.diagnostic.severity.WARN, float = true }) end";
      options.desc = "Prev Warning";
    }

    # location list
    {
      mode = "n";
      key = "<leader>xl";
      action.__raw = ''
        function()
          local win = vim.fn.getloclist(0, { winid = 0 }).winid
          if win ~= 0 then vim.cmd.lclose() else pcall(vim.cmd.lopen) end
        end
      '';
      options.desc = "Location List";
    }

    # quickfix list
    {
      mode = "n";
      key = "<leader>xq";
      action.__raw = ''
        function()
          local win = vim.fn.getqflist({ winid = 0 }).winid
          if win ~= 0 then vim.cmd.cclose() else pcall(vim.cmd.copen) end
        end
      '';
      options.desc = "Quickfix List";
    }
    {
      mode = "n";
      key = "[q";
      action.__raw = "vim.cmd.cprev";
      options.desc = "Previous Quickfix";
    }
    {
      mode = "n";
      key = "]q";
      action.__raw = "vim.cmd.cnext";
      options.desc = "Next Quickfix";
    }

    # highlights under cursor
    {
      mode = "n";
      key = "<leader>ui";
      action.__raw = "vim.show_pos";
      options.desc = "Inspect Pos";
    }
    {
      mode = "n";
      key = "<leader>uI";
      action.__raw = "function() vim.treesitter.inspect_tree() vim.api.nvim_input('I') end";
      options.desc = "Inspect Tree";
    }

    # term mappings
    {
      mode = "t";
      key = "<C-/>";
      action = "<cmd>close<cr>";
      options.desc = "Hide Terminal";
    }
    {
      mode = "t";
      key = "<c-_>";
      action = "<cmd>close<cr>";
      options.desc = "which_key_ignore";
    }

    # native snippets
    {
      mode = "s";
      key = "<Tab>";
      action.__raw = "function() return vim.snippet.active({ direction = 1 }) and '<cmd>lua vim.snippet.jump(1)<cr>' or '<Tab>' end";
      options = {
        expr = true;
        desc = "Jump Next";
      };
    }
    {
      mode = [
        "i"
        "s"
      ];
      key = "<S-Tab>";
      action.__raw = "function() return vim.snippet.active({ direction = -1 }) and '<cmd>lua vim.snippet.jump(-1)<cr>' or '<S-Tab>' end";
      options = {
        expr = true;
        desc = "Jump Previous";
      };
    }

    # up/down
    {
      mode = [
        "n"
        "x"
      ];
      key = "j";
      action = "v:count == 0 ? 'gj' : 'j'";
      options = {
        desc = "Down";
        expr = true;
        silent = true;
      };
    }
    {
      mode = [
        "n"
        "x"
      ];
      key = "<Down>";
      action = "v:count == 0 ? 'gj' : 'j'";
      options = {
        desc = "Down";
        expr = true;
        silent = true;
      };
    }
    {
      mode = [
        "n"
        "x"
      ];
      key = "k";
      action = "v:count == 0 ? 'gk' : 'k'";
      options = {
        desc = "Up";
        expr = true;
        silent = true;
      };
    }
    {
      mode = [
        "n"
        "x"
      ];
      key = "<Up>";
      action = "v:count == 0 ? 'gk' : 'k'";
      options = {
        desc = "Up";
        expr = true;
        silent = true;
      };
    }

    # move lines
    {
      mode = "n";
      key = "<A-j>";
      action = "<cmd>execute 'move .+' . v:count1<cr>==";
      options.desc = "Move Down";
    }
    {
      mode = "n";
      key = "<A-k>";
      action = "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==";
      options.desc = "Move Up";
    }
    {
      mode = "i";
      key = "<A-j>";
      action = "<esc><cmd>m .+1<cr>==gi";
      options.desc = "Move Down";
    }
    {
      mode = "i";
      key = "<A-k>";
      action = "<esc><cmd>m .-2<cr>==gi";
      options.desc = "Move Up";
    }
    {
      mode = "v";
      key = "<A-j>";
      action = ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv";
      options.desc = "Move Down";
    }
    {
      mode = "v";
      key = "<A-k>";
      action = ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv";
      options.desc = "Move Up";
    }

    # insert mode
    {
      mode = [
        "c"
        "i"
        "t"
      ];
      key = "<M-BS>";
      action = "<C-w>";
      options.desc = "Delete Word";
    }

    # cursor nav in insert mode
    {
      mode = "i";
      key = "<M-h>";
      action = "<left>";
      options.desc = "Move Cursor Left";
    }
    {
      mode = "i";
      key = "<M-l>";
      action = "<right>";
      options.desc = "Move Cursor Right";
    }
    {
      mode = "i";
      key = "<M-j>";
      action = "<down>";
      options.desc = "Move Cursor Down";
    }
    {
      mode = "i";
      key = "<M-k>";
      action = "<up>";
      options.desc = "Move Cursor Up";
    }

    # tabs
    {
      mode = "n";
      key = "<leader><tab>l";
      action = "<cmd>tablast<cr>";
      options.desc = "Last Tab";
    }
    {
      mode = "n";
      key = "<leader><tab>o";
      action = "<cmd>tabonly<cr>";
      options.desc = "Close Other Tabs";
    }
    {
      mode = "n";
      key = "<leader><tab>f";
      action = "<cmd>tabfirst<cr>";
      options.desc = "First Tab";
    }
    {
      mode = "n";
      key = "<leader><tab><tab>";
      action = "<cmd>tabnew<cr>";
      options.desc = "New Tab";
    }
    {
      mode = "n";
      key = "<leader><tab>]";
      action = "<cmd>tabnext<cr>";
      options.desc = "Next Tab";
    }
    {
      mode = "n";
      key = "<leader><tab>d";
      action = "<cmd>tabclose<cr>";
      options.desc = "Close Tab";
    }
    {
      mode = "n";
      key = "<leader><tab>[";
      action = "<cmd>tabprevious<cr>";
      options.desc = "Previous Tab";
    }

    # move to window with <ctrl> hjkl keys
    {
      mode = "n";
      key = "<C-h>";
      action = "<C-w>h";
      options = {
        desc = "Go to Left Window";
        remap = true;
      };
    }
    {
      mode = "n";
      key = "<C-j>";
      action = "<C-w>j";
      options = {
        desc = "Go to Lower Window";
        remap = true;
      };
    }
    {
      mode = "n";
      key = "<C-k>";
      action = "<C-w>k";
      options = {
        desc = "Go to Upper Window";
        remap = true;
      };
    }
    {
      mode = "n";
      key = "<C-l>";
      action = "<C-w>l";
      options = {
        desc = "Go to Right Window";
        remap = true;
      };
    }

    # window resizing
    {
      mode = "n";
      key = "<C-Up>";
      action = "<cmd>resize +2<cr>";
      options.desc = "Increase Window Height";
    }
    {
      mode = "n";
      key = "<C-Down>";
      action = "<cmd>resize -2<cr>";
      options.desc = "Decrease Window Height";
    }
    {
      mode = "n";
      key = "<C-Left>";
      action = "<cmd>vertical resize -2<cr>";
      options.desc = "Decrease Window Width";
    }
    {
      mode = "n";
      key = "<C-Right>";
      action = "<cmd>vertical resize +2<cr>";
      options.desc = "Increase Window Width";
    }

    {
      mode = "n";
      key = "<C-S-h>";
      action = "<C-w><";
    }
    {
      mode = "n";
      key = "<C-S-l>";
      action = "<C-w>>";
    }
    {
      mode = "n";
      key = "<C-S-k>";
      action = "<C-w>+";
    }
    {
      mode = "n";
      key = "<C-S-j>";
      action = "<C-w>-";
    }

    # windows
    {
      mode = "n";
      key = "<leader>-";
      action = "<C-W>s";
      options = {
        desc = "Split Window Below";
        remap = true;
      };
    }
    {
      mode = "n";
      key = "<leader>|";
      action = "<C-W>v";
      options = {
        desc = "Split Window Right";
        remap = true;
      };
    }
    {
      mode = "n";
      key = "<leader>=";
      action = "<C-w>=";
      options = {
        desc = "Make splits equal size";
        remap = true;
      };
    }
    {
      mode = "n";
      key = "<leader>wd";
      action = "<C-W>c";
      options = {
        desc = "Delete Window";
        remap = true;
      };
    }

    # buffers
    {
      mode = "n";
      key = "<S-h>";
      action = "<cmd>bprevious<cr>";
      options.desc = "Prev Buffer";
    }
    {
      mode = "n";
      key = "<S-l>";
      action = "<cmd>bnext<cr>";
      options.desc = "Next Buffer";
    }
    {
      mode = "n";
      key = "[b";
      action = "<cmd>bprevious<cr>";
      options.desc = "Prev Buffer";
    }
    {
      mode = "n";
      key = "]b";
      action = "<cmd>bnext<cr>";
      options.desc = "Next Buffer";
    }
    {
      mode = "n";
      key = "<leader>bb";
      action = "<cmd>e #<cr>";
      options.desc = "Switch to Other Buffer";
    }
    {
      mode = "n";
      key = "<leader>`";
      action = "<cmd>e #<cr>";
      options.desc = "Switch to Other Buffer";
    }
    {
      mode = "n";
      key = "<leader>bD";
      action = "<cmd>:bd<cr>";
      options.desc = "Delete Buffer and Window";
    }
  ];
}
