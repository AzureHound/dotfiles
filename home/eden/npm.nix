{ config, ... }:

let
  cfg = config.xdg;
in

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
    NPM_CONFIG_INIT_MODULE = "${cfg.configHome}/npm/config/npm-init.js";
    NPM_CONFIG_CACHE = "${cfg.cacheHome}/npm";
    NPM_CONFIG_TMP = "$XDG_RUNTIME_DIR/npm";
    NPM_PACKAGES = "${cfg.dataHome}/.npm-packages";
    NPM_PACKAGES_BIN = "${cfg.dataHome}/.npm-packages/bin";
  };
}
