{ pkgs, ... }:

{
  plugins = {
    lsp.servers.jsonls = {
      enable = true;
      filetypes = [
        "json"
        "jsonc"
      ];

      settings.json.validate.enable = true;
    };
    conform-nvim.settings.formatters_by_ft.json = [ "prettierd" ];
    treesitter.grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [ json ];

    schemastore = {
      enable = true;
      json.enable = true;
    };
  };
}
