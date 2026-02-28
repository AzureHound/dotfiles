{
  plugins = {
    lsp = {
      enable = true;
      inlayHints = true;

      capabilities = ''
        vim.tbl_deep_extend("force", vim.lsp.protocol.make_client_capabilities(), {
          workspace = {
            fileOperations = {
              didRename = true,
              willRename = true,
            },
          },
          textDocument = {
            semanticTokens = {
              multilineTokenSupport = true,
            },
          },
        })
      '';

      onAttach = ''
        -- folding
        if client and client:supports_method("textDocument/foldingRange") then
          vim.wo.foldmethod = "expr"
          vim.wo.foldexpr = "v:lua.vim.lsp.foldexpr()"
        end

        -- inlay hints exclusion
        local exclude = { "vue" }
        if vim.tbl_contains(exclude, vim.bo[bufnr].filetype) then
          vim.lsp.inlay_hint.enable(false, { bufnr = bufnr })
        end
      '';

      servers = {
        typos_lsp = {
          enable = true;
          filetypes = [
            "markdown"
            "text"
            "gitcommit"
            "gitrebase"
            "mail"
          ];
        };
      };

      keymaps.lspBuf = {
        gd = {
          action = "definition";
          desc = "Goto Definition";
        };
        gr = {
          action = "references";
          desc = "References";
        };
        gI = {
          action = "implementation";
          desc = "Goto Implementation";
        };
        gy = {
          action = "type_definition";
          desc = "Goto T[y]pe Definition";
        };
        gD = {
          action = "declaration";
          desc = "Goto Declaration";
        };
        K = {
          action = "hover";
          desc = "Hover";
        };
        gK = {
          action = "signature_help";
          desc = "Signature Help";
        };
        "<leader>ca" = {
          action = "code_action";
          desc = "Code Action";
        };
        # "<leader>cc" = { action = "codelens_run"; desc = "Run Codelens"; };
        # "<leader>cC" = { action = "codelens_refresh"; desc = "Refresh & Display Codelens"; };
        "<leader>cr" = {
          action = "rename";
          desc = "Rename";
        };
      };
    };

    lsp-signature = {
      enable = true;
      lazyLoad.settings.event = [ "LspAttach" ];
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>cc";
      action.__raw = "function() vim.lsp.codelens.run() end";
      options.desc = "Run Codelens";
    }
    {
      mode = "n";
      key = "<leader>cC";
      action.__raw = "function() vim.lsp.codelens.refresh() end";
      options.desc = "Refresh Codelens";
    }

    {
      mode = "n";
      key = "<leader>cl";
      action.__raw = "function() Snacks.picker.lsp_config() end";
      options.desc = "Lsp Info";
    }
    {
      mode = "i";
      key = "<c-k>";
      action.__raw = "function() vim.lsp.buf.signature_help() end";
      options.desc = "Signature Help";
    }
    {
      mode = "n";
      key = "<leader>cR";
      action.__raw = "function() Snacks.rename.rename_file() end";
      options.desc = "Rename File";
    }
    {
      mode = "n";
      key = "<leader>cA";
      action.__raw = "function() vim.lsp.buf.code_action({ context = { only = { 'source' }, diagnostics = {} } }) end";
      options.desc = "Source Action";
    }
    {
      mode = "n";
      key = "<leader>co";
      action.__raw = "function() vim.lsp.buf.code_action({ context = { only = { 'source.organizeImports' }, diagnostics = {} } }) end";
      options.desc = "Organize Imports";
    }

    # diagnostic navigation
    {
      mode = "n";
      key = "<leader>cd";
      action.__raw = "function() vim.diagnostic.open_float() end";
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

    # document highlights [Snacks.words]
    {
      mode = "n";
      key = "]]";
      action.__raw = "function() Snacks.words.jump(vim.v.count1) end";
      options.desc = "Next Reference";
    }
    {
      mode = "n";
      key = "[[";
      action.__raw = "function() Snacks.words.jump(-vim.v.count1) end";
      options.desc = "Prev Reference";
    }
    {
      mode = "n";
      key = "<a-n>";
      action.__raw = "function() Snacks.words.jump(vim.v.count1, true) end";
      options.desc = "Next Reference";
    }
    {
      mode = "n";
      key = "<a-p>";
      action.__raw = "function() Snacks.words.jump(-vim.v.count1, true) end";
      options.desc = "Prev Reference";
    }
  ];
}
