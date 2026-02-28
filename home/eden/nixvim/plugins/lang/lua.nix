{ pkgs, ... }:

{
  plugins = {
    lsp.servers.lua_ls = {
      enable = true;
      settings.Lua = {
        workspace.checkThirdParty = false;
        codeLens.enable = true;
        completion.callSnippet = "Replace";
        doc.privateName = [ "^_" ];
        hint = {
          enable = true;
          setType = false;
          paramType = true;
          paramName = "Disable";
          semicolon = "Disable";
          arrayIndex = "Disable";
        };
      };
    };

    conform-nvim.settings = {
      formatters_by_ft.lua = [ "stylua" ];
      formatters.stylua.args = [
        "--column-width"
        "120"
        "--indent-type"
        "Spaces"
        "--indent-width"
        "2"
        "-"
      ];
    };

    blink-cmp.settings.sources.per_filetype.lua = [
      "lsp"
      "path"
      "snippets"
      "buffer"
      "lazydev"
    ];

    treesitter.grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      lua
      luadoc
      luap
    ];

    lazydev = {
      enable = true;
      settings.library = [
        {
          path = "\${3rd}/luv/library";
          words = [ "vim%.uv" ];
        }
        { path = "\${vim.fn.stdpath 'config'}/lua"; }
        {
          path = "nvim-lspconfig";
          words = [ "lspconfig.settings" ];
        }
        {
          path = "snacks.nvim";
          words = [ "Snacks" ];
        }
      ];
    };
  };

  extraPackages = with pkgs; [ stylua ];
}
