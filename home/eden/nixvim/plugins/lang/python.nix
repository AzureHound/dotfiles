{ pkgs, ... }:

{
  plugins = {
    lsp.servers = {
      basedpyright = {
        enable = true;
        settings.basedpyright.analysis = {
          autoSearchPaths = true;
          diagnosticMode = "openFilesOnly";
          useLibraryCodeForTypes = true;
        };
      };

      ruff = {
        enable = true;
        onAttach.function = ''
          if client.name == "ruff" then
            client.server_capabilities.hoverProvider = false
          end
        '';
      };
    };

    dap.enable = true;
    dap-python.enable = true;

    conform-nvim.settings.formatters_by_ft.python = [
      "ruff_format"
      "ruff_organize_imports"
    ];

    lint.lintersByFt.python = [ "ruff" ];

    treesitter.grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      python
      requirements
    ];
  };

  extraPackages = with pkgs; [ ruff ];
}
