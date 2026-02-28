{ pkgs, ... }:

{
  plugins = {
    lsp.servers.vtsls = {
      enable = true;
      settings = {
        complete_function_calls = true;
        vtsls = {
          enableMoveToFileCodeAction = true;
          autoUseWorkspaceTsdk = true;
          experimental.completion.enableServerSideFuzzyMatch = true;
        };
        typescript.updateImportsOnFileMove.enabled = "always";
        javascript.updateImportsOnFileMove.enabled = "always";
      };
    };

    conform-nvim.settings.formatters_by_ft = {
      javascript = [ "prettierd" ];
      typescript = [ "prettierd" ];
      javascriptreact = [ "prettierd" ];
      typescriptreact = [ "prettierd" ];
    };

    lint.lintersByFt = {
      javascript = [ "eslint_d" ];
      typescript = [ "eslint_d" ];
      javascriptreact = [ "eslint_d" ];
      typescriptreact = [ "eslint_d" ];
    };

    treesitter.grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      javascript
      jsdoc
      tsx
      typescript
    ];
  };

  extraPackages = with pkgs; [
    prettierd
    eslint_d
  ];
}
