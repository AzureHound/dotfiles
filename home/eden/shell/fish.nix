{ lib, pkgs, ... }:

let
  inherit (lib.strings) optionalString;
in

{
  programs.fish = {

    plugins = with pkgs.fishPlugins; [
      {
        name = "autopair";
        inherit (autopair) src;
      }
      {
        name = "fish-ssh-agent";
        src = pkgs.fetchFromGitHub {
          owner = "danhper";
          repo = "fish-ssh-agent";
          rev = "master";
          hash = "sha256-cFroQ7PSBZ5BhXzZEKTKHnEAuEu8W9rFrGZAb8vTgIE=";
        };
      }
      {
        name = "fzf";
        inherit (fzf) src;
      }
      {
        name = "puffer";
        inherit (puffer) src;
      }
      {
        name = "safe-rm";
        src = pkgs.fetchFromGitHub {
          owner = "fishingline";
          repo = "safe-rm";
          rev = "master";
          hash = "sha256-chou3NBxs/RZqVJd8oPmlz2LqkZhfpVDKqUspXvU2KY=";
        };
      }
      {
        name = "sponge";
        inherit (sponge) src;
      }
    ];

    shellAliases = {
      private = "fish -P";
    };

    shellAbbrs = {
      Aio = "sudo liquidctl --match \"NZXT Kraken X\" set pump speed 20";
      d = "docker";
      gamedir = "cd /mnt/games/SteamLibrary/steamapps/common";
      HyperX = "mechsim -V 100 -s cherrymx-black-pbt";
    };

    functions = {
      "." = ''
        set -l input $argv[1]
        if echo $input | grep -q '^[1-9][0-9]*$'
          set -l levels $input
          for i in (seq $levels)
            cd ..
          end
        else
          echo "Invalid input format. Please use '<number>' to go back a specific number of directories."
        end
      '';

      bj = "nohup $argv </dev/null &>/dev/null &";

      img = ''
        if test "$TERM" = xterm-kitty -o -n "$KITTY_WINDOW_ID"
          kitten icat $argv
        else if test "$TERM" = foot -o "$TERM" = xterm-256color -o -n "$FOOT_SERVER"
          chafa --format=sixels $argv
        else
          if command -v img2sixel >/dev/null 2>&1
            img2sixel $argv
          else if command -v kitten >/dev/null 2>&1
            kitten icat $argv
          else
            echo "No image viewer available"
          end
        end
      '';

      fish_user_key_bindings = ''
        set -gx fish_key_bindings fish_vi_key_bindings
        fish_default_key_bindings -M insert
        fish_vi_key_bindings --no-erase insert

        bind -M visual -m default y 'fish_clipboard_copy; commandline -f end-selection repaint-mode'
        bind yy fish_clipboard_copy
        bind p fish_clipboard_paste

        bind -M insert \e\z zi
      '';

      starship_transient_prompt_func = "starship module character";
      starship_transient_rprompt_func = "starship module time";
    };

    loginShellInit = optionalString pkgs.stdenv.hostPlatform.isDarwin ''
      fish_add_path --move --prepend --path $HOME/.nix-profile/bin /run/wrappers/bin /etc/profiles/per-user/$USER/bin /run/current-system/sw/bin /nix/var/nix/profiles/default/bin
    '';

    interactiveShellInit = ''
      set fish_greeting
      set -g theme_display_date no
      set -g theme_nerd_fonts yes
      set -g theme_newline_cursor yes

      set fish_cursor_default     line      blink
      set fish_cursor_insert      line      blink
      set fish_cursor_replace_one line      blink
      set fish_cursor_visual      line      blink

      set --global sponge_delay 2
      set --global sponge_purge_only_on_exit false
      set --global sponge_allow_previously_successful true
      set --global sponge_filters sponge_filter_failed sponge_filter_matched
      set --global sponge_successful_exit_codes 0

      set -gx PINENTRY_USER_DATA curses
      set -gx GPG_TTY (tty)
      set -e SSH_AGENT_PID
      if test -z $gnupg_SSH_AUTH_SOCK_BY; or test $gnupg_SSH_AUTH_SOCK_BY -ne $fish_pid
        set -gx SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
      end
      gpg-connect-agent updatestartuptty /bye >/dev/null 2>&1
    '';
  };
}
