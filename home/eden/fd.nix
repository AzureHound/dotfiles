{ config, ... }:

{
  programs.fd = {
    inherit (config.pixel.profiles.workstation) enable;

    hidden = true;
    ignores = [
      "**/*.app/*"
      "**/*.pxd/*"
      "Juegos/**"

      # git
      ".git"
      ".gitignore"

      # INFO files
      "*INFO*"

      # general
      "*.bak"
      ".editorconfig"
      "LICENSE"

      # node
      ".eslintrc"
      ".eslintrc.json"
      ".prettierrc"
      "biome.json"
      "esbuild.config.mjs"
      "jsconfig.json"
      "manifest.json"
      "node_modules/*"
      "package.json"
      "package-lock.json"
      "tsconfig.json"
      "versions.json"

      # python
      "__init__.py"
      "pyproject.toml"
      "requirements.txt"

      # nvim-plugins
      "stylua.toml"

      # vscode
      ".vscode"

      # yarn
      ".yarn"
    ];
  };
}
