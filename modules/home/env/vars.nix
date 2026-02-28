{ config, osConfig, ... }:

let
  inherit (config.pixel.programs) defaults;
in

{
  home.sessionVariables = {
    EDITOR = defaults.editor;
    VISUAL = defaults.editor;
    GIT_EDITOR = defaults.editor;
    TERMINAL = defaults.terminal;
    SYSTEMD_PAGERSECURE = true;
    PAGER = defaults.pager;
    MANPAGER = defaults.manpager;

    DO_NOT_TRACK = 1;
    FLAKE = osConfig.pixel.environment.flakePath;
  };
}
