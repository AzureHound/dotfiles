{
  lib,
  config,
  ...
}:

let
  inherit (lib.modules) mkForce;
in

{
  programs.nushell = {
    shellAliases = {
      la = "ls -a";
      mkdir = mkForce "^mkdir -pv";
    };

    environmentVariables = config.home.sessionVariables;

    extraConfig = ''
      $env.config.history.max_size = 100000
      $env.config.history.path = ("~/.local/share/nushell/history.txt" | path expand)

      $env.config.show_banner = false
      $env.config.edit_mode = "vi"
      $env.config.buffer_editor = "nvim"

      $env.config.cursor_shape = {
        vi_insert: blink_line
        vi_normal: line
      }
    '';

    extraEnv = ''
      mkdir ("~/.local/share/nushell" | path expand)

      $env.PINENTRY_USER_DATA = "curses"
      $env.GPG_TTY = (tty | str trim)
      try { ^gpg-connect-agent updatestartuptty /bye }

      $env.EDITOR = "nvim"
      $env.PATH ++= ['~/.local/bin']

      $env.PROMPT_COMMAND_RIGHT = {||}
      $env.PROMPT_INDICATOR_VI_INSERT = "  "
      $env.PROMPT_INDICATOR_VI_NORMAL = "  "
      $env.PROMPT_MULTILINE_INDICATOR = " ❯ "

      $env.TRANSIENT_PROMPT_COMMAND = "  "
      $env.TRANSIENT_PROMPT_COMMAND_RIGHT = null
      $env.TRANSIENT_PROMPT_MULTILINE_INDICATOR = " ❯ "
      $env.TRANSIENT_PROMPT_INDICATOR = ""
      $env.TRANSIENT_PROMPT_INDICATOR_VI_NORMAL = ""
      $env.TRANSIENT_PROMPT_INDICATOR_VI_INSERT = ""
    '';
  };
}
