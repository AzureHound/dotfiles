{ pkgs, ... }:

{
  plugins = {
    lsp.servers.yamlls = {
      enable = true;
      filetypes = [
        "yml"
        "yaml"
      ];

      settings.yaml = {
        schemaStore.enable = false;
        schemaStore.url = "";
      };
    };
    conform-nvim.settings = {
      formatters.yamlfmt = {
        prepend_args = [
          "-formatter"
          "retain_line_breaks=true"
        ];
      };

      formatters_by_ft.yaml = [ "yamlfmt" ];
    };
    treesitter.grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [ yaml ];

    schemastore = {
      enable = true;
      yaml.enable = true;
    };
  };

  extraPackages = with pkgs; [ yamlfmt ];
}
