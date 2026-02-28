{ config, ... }:

{
  programs.bash = {
    enable = true;

    historyFile = "${config.xdg.dataHome}/bash/history";
    historyFileSize = 100000;
    historyControl = [
      "erasedups"
      "ignoredups"
      "ignorespace"
      "ignoreboth"
    ];
    historyIgnore = [
      "&"
      "[ ]*"
      "exit"
      "ls"
      "bg"
      "fg"
      "history"
      "clear"
    ];

    shellOptions = [
      "autocd"
      "cdspell"
      "checkjobs"
      "checkwinsize"
      "dirspell"
      "extglob"
      "globstar"
      "histappend"
      "no_empty_cmd_completion"
    ];

    initExtra = ''
      [[ $- != *i* ]] && return

      export PINENTRY_USER_DATA=curses
      export GPG_TTY="$(tty)"
      gpg-connect-agent updatestartuptty /bye >/dev/null 2>&1

      PS1='\[\e[0;36m\]\u\[\e[0;37m\]@\[\e[0;34m\]\h\[\e[0;33m\] \w\[\e[0m\]$(if git rev-parse --is-inside-work-tree &>/dev/null; then echo " \[\e[0;32m\] $(git symbolic-ref --short HEAD 2>/dev/null || echo "HEAD")"; fi)\n\[\e[38;2;147;154;183m\] \[\e[0m\]'

      function img() {
        if [ "$TERM" = "xterm-kitty" ] || [ -n "$KITTY_WINDOW_ID" ]; then
          kitten icat "$@"
        elif [ "$TERM" = "foot" ] || [ "$TERM" = "xterm-256color" ] || [ -n "$FOOT_SERVER" ]; then
          chafa --format=sixels "$@"
        else
          if command -v img2sixel >/dev/null 2>&1; then
            img2sixel "$@"
          elif command -v kitten >/dev/null 2>&1; then
            kitten icat "$@"
          else
            echo "No image viewer available"
          fi
        fi
      }

      set -o vi

      bind '"\C-p": history-search-backward'
      bind '"\C-n": history-search-forward'
      bind '"\ew": backward-kill-word'
      bind '"\C-l": clear-screen'
      bind -m vi-insert -x '"\e[A": __atuin_history'
      bind -m vi-insert -x '"\eOA": __atuin_history'
    '';
  };
}
