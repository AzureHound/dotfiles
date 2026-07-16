{ pkgs, ... }:

{
  globals.markdown_recommended_style = 0;

  plugins = {
    lsp.servers.marksman.enable = true;
    conform-nvim.settings.formatters_by_ft.markdown = [
      "markdown-toc"
      "markdownlint-cli2"
    ];
    lint.lintersByFt.markdown = [ "markdownlint-cli2" ];
    blink-cmp.settings.sources.per_filetype.markdown = [
      "lsp"
      "thesaurus"
    ];
    treesitter.grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      markdown
      markdown_inline
    ];
  };

  extraPackages = with pkgs; [
    markdown-toc
    markdownlint-cli2
  ];
}
