{ config, ... }:

{
  programs.npm = {
    enable = true;

    settings = {
      prefix = "${config.xdg.dataHome}/npm";
      cache = "${config.xdg.cacheHome}/npm";
      "init-module" = "${config.xdg.configHome}/npm/config/npm-init.js";
      "logs-dir" = "${config.xdg.stateHome}/npm/logs";
      ignore-scripts = true;
      allow-git = "none";
      min-release-age = 2;
    };
  };

  home.sessionVariables = {
    NPM_CONFIG_CACHE = "${config.xdg.cacheHome}/npm";
    NPM_CONFIG_TMP = "$XDG_RUNTIME_DIR/npm";
    NPM_PACKAGES = "${config.xdg.dataHome}/.npm-packages";
    NPM_PACKAGES_BIN = "${config.xdg.dataHome}/.npm-packages/bin";
  };
}
