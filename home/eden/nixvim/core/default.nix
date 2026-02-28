{ pkgs, ... }:

{
  imports = [
    ./options.nix
    ./autocmds.nix
    ./keymaps.nix
  ];

  clipboard.providers.wl-copy.enable = pkgs.stdenv.hostPlatform.isLinux;
  dependencies = {
    # distant.enable = true;
  };

  luaLoader.enable = true;
  performance.byteCompileLua.enable = true;

  diagnostic.settings = {
    signs.text.__raw = ''
      {
        [vim.diagnostic.severity.ERROR] = vim.g.icons.diagnostics.Error,
        [vim.diagnostic.severity.WARN] = vim.g.icons.diagnostics.Warn,
        [vim.diagnostic.severity.HINT] = vim.g.icons.diagnostics.Hint,
        [vim.diagnostic.severity.INFO] = vim.g.icons.diagnostics.Info,
      }
    '';

    underline = true;
    update_in_insert = false;
    virtual_text = {
      spacing = 4;
      source = "if_many";
      prefix = "●";
    };
    severity_sort = true;
  };

  globals = {
    icons = {
      misc.dots = "󰇘";
      ft = {
        gh = " ";
        octo = " ";
        "markdown.gh" = " ";
      };
      dap = {
        Stopped = [
          "󰁕 "
          "DiagnosticWarn"
          "DapStoppedLine"
        ];
        Breakpoint = " ";
        BreakpointCondition = " ";
        BreakpointRejected = [
          " "
          "DiagnosticError"
        ];
        LogPoint = ".>";
      };
      diagnostics = {
        Error = " ";
        Warn = " ";
        Hint = " ";
        Info = " ";
      };
      git = {
        added = "+";
        modified = "󰏪 ";
        removed = "-";
      };
      kinds = {
        Array = " ";
        Boolean = "󰨙 ";
        Class = " ";
        Codeium = "󰘦 ";
        Color = " ";
        Control = " ";
        Collapsed = " ";
        Constant = "󰏿 ";
        Constructor = "󰒓 ";
        Copilot = " ";
        Enum = " ";
        EnumMember = " ";
        Event = " ";
        Field = " ";
        File = " ";
        Folder = " ";
        Function = "󰊕 ";
        Interface = " ";
        Key = " ";
        Keyword = " ";
        Method = "󰊕 ";
        Module = " ";
        Namespace = "󰦮 ";
        Null = " ";
        Number = "󰎠 ";
        Object = " ";
        Operator = " ";
        Package = " ";
        Property = " ";
        Reference = " ";
        Snippet = "󱄽 ";
        String = " ";
        Struct = "󰆼 ";
        Supermaven = " ";
        TabNine = "󰏚 ";
        Text = "󰉿 ";
        TypeParameter = " ";
        Unit = " ";
        Value = " ";
        Variable = "󰀫 ";
      };
    };

    kind_filter = {
      default = [
        "Class"
        "Constructor"
        "Enum"
        "Field"
        "Function"
        "Interface"
        "Method"
        "Module"
        "Namespace"
        "Package"
        "Property"
        "Struct"
        "Trait"
      ];
      markdown = false;
      help = false;
      lua = [
        "Class"
        "Constructor"
        "Enum"
        "Field"
        "Function"
        "Interface"
        "Method"
        "Module"
        "Namespace"
        "Property"
        "Struct"
        "Trait"
      ];
    };
  };
}
