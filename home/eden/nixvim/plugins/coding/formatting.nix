{ pkgs, ... }:

{
  plugins.conform-nvim = {
    enable = true;

    settings = {
      default_format_opts = {
        timeout_ms = 3000;
        async = false;
        quiet = false;
        lsp_format = "fallback";
      };

      formatters_by_ft = {
        "*" = [ "codespell" ];
        "_" = [
          "squeeze_blanks"
          "trim_whitespace"
          "trim_newlines"
        ];
      };

      formatters = {
        injected = {
          options.ignore_errors = true;
        };
      };

      log_level = "warn";
      notify_on_error = false;
      notify_no_formatters = false;
    };
  };

  autoCmd = [
    {
      event = "BufWritePre";
      callback.__raw = ''
        function(args)
          if vim.g.disable_autoformat or vim.b[args.buf].disable_autoformat then
            return
          end
          require("conform").format({ bufnr = args.buf })
        end
      '';
    }
  ];

  keymaps = [
    {
      mode = [
        "n"
        "v"
      ];
      key = "<leader>cf";
      action.__raw = ''function() require("conform").format({ lsp_fallback = true }) end'';
      options.desc = "Format Buffer";
    }
    {
      mode = [
        "n"
        "x"
      ];
      key = "<leader>cF";
      action.__raw = ''function() require("conform").format({ formatters = { "injected" }, timeout_ms = 3000 }) end'';
      options.desc = "Format Injected Langs";
    }
    {
      mode = "n";
      key = "<leader>uf";
      action.__raw = ''
        function()
          vim.g.disable_autoformat = not vim.g.disable_autoformat
          print("Global autoformat: " .. (vim.g.disable_autoformat and "disabled" or "enabled"))
        end
      '';
      options.desc = "Toggle Autoformat [Global]";
    }
  ];

  extraPackages = with pkgs; [ codespell ];
}
