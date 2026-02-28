{ pkgs, ... }:

{
  plugins = {
    lsp.servers.elixirls.enable = true;
    dap = {
      adapters.executables.elixir.command = "elixir-ls-debugger";
      configurations.elixir = [
        {
          type = "elixir";
          name = "Run Elixir";
          request = "launch";
          program = "$\\{file\\}";
        }
      ];
    };
    treesitter.grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [ elixir ];
  };

  extraPackages = with pkgs; [ elixir-ls ];
}
