{ config, ... }:

{
  programs.starship = {
    inherit (config.programs.fish) enable;

    enableBashIntegration = false;
    enableNushellIntegration = false;
    enableZshIntegration = false;

    configPath = "${config.xdg.configHome}/starship/starship.toml";

    settings = {
      add_newline = true;
      command_timeout = 200;
      continuation_prompt = "[❯❯](fg:teal)";
      format = "$os$directory\${custom.giturl}$git_branch$git_status$git_metrics$sudo$shell$fill$aws$c$dart$golang$java$jobs$kotlin$lua$nix_shell$nodejs$python$package$ruby$rust$swift\${custom.docker}\${custom.hypr}\${custom.neovim}$cmd_duration$line_break$character";
      scan_timeout = 30;

      # right_format = ''
      #   $time\
      #   $cmd_duration\
      # '';

      aws = {
        symbol = " ";
        style = "yellow";
        format = "[$symbol($profile )(\\[$duration\\] )]($style)";
      };

      bun = {
        symbol = " ";
        style = "subtext1";
        format = "[$symbol($version )]($style)";
      };

      c = {
        symbol = " ";
        style = "teal";
        format = "[$symbol($version )]($style)";
      };

      character = {
        success_symbol = "[](green)";
        error_symbol = "[](red)";
        vimcmd_symbol = "[](green)";
        vimcmd_visual_symbol = "[](mauve)";
        vimcmd_replace_symbol = "[](yellow)";
        vimcmd_replace_one_symbol = "[](yellow)";
      };

      cmd_duration = {
        style = "fg:yellow";
        format = " [$duration]($style)";
        min_time = 100;
      };

      container = {
        symbol = "󰏖 ";
        style = "fg:blue";
        format = "[$symbol]($style)";
      };

      custom = {
        giturl = {
          disabled = false;
          format = "$output  ";
          command = ''
            GIT_REMOTE=$(command git ls-remote --get-url 2> /dev/null)
            if [[ "$GIT_REMOTE" =~ "github" ]]; then
                GIT_REMOTE_SYMBOL=""
            elif [[ "$GIT_REMOTE" =~ "gitlab" ]]; then
                GIT_REMOTE_SYMBOL=""
            elif [[ "$GIT_REMOTE" =~ "forgejo" ]]; then
                GIT_REMOTE_SYMBOL=""
            elif [[ "$GIT_REMOTE" =~ "bitbucket" ]]; then
                GIT_REMOTE_SYMBOL=""
            elif [[ "$GIT_REMOTE" =~ "aur" ]]; then
                GIT_REMOTE_SYMBOL="󰣇"
            elif [[ "$GIT_REMOTE" =~ "git" ]]; then
                GIT_REMOTE_SYMBOL=""
            else
                GIT_REMOTE_SYMBOL=""
            fi
            echo "$GIT_REMOTE_SYMBOL"
          '';
          shell = [
            "bash"
            "--noprofile"
            "--norc"
          ];
          when = "git rev-parse --is-inside-work-tree 2> /dev/null";
        };

        docker = {
          style = "bold blue";
          format = "[  $output]($style)";
          command = "docker -v | awk '{print \"v\"$3}' | sed 's/,//' 2>/dev/null || true";
          detect_files = [
            "compose.yml"
            "docker-compose.yml"
            "docker-compose.yaml"
            "Dockerfile"
          ];
        };

        hypr = {
          style = "blue";
          format = "[ $output]($style)";
          command = "if [[ \"$PWD\" == \"$HOME/.config/hypr\"* ]]; then hyprland --version | head -1 | awk '{print \"v\" $2}'; fi";
          detect_files = [ "hyprland.lua" ];
          shell = [ "bash" ];
        };

        neovim = {
          style = "green";
          format = "[  $output]($style)";
          command = "nvim --version | head -1 | awk '{print $2}'";
          detect_folders = [ "lua" ];
          shell = [ "bash" ];
        };
      };

      dart = {
        symbol = " ";
        style = "blue";
        format = "[$symbol($version )]($style)";
      };

      deno = {
        symbol = " ";
        style = "green";
        format = "[$symbol($version )]($style)";
      };

      directory = {
        style = "fg:subtext0";
        format = "[$path ]($style)[$read_only]($read_only_style)";
        truncation_length = 6;
        truncation_symbol = "…/";
        truncate_to_repo = true;
        # repo_root_style = "teal";
        # repo_root_format = "[$repo_root]($repo_root_style)[$path]($style)[$read_only]($read_only_style) ";
        read_only = " ";
        read_only_style = "red";
        fish_style_pwd_dir_length = 1;

        substitutions = {
          ".config" = ".config  ";
          "Archive" = "Archive  ";
          "Desktop" = "Desktop  ";
          "Developer" = "Developer 󱌢 ";
          "Documents" = "Documents  ";
          "documents" = "documents  ";
          "Downloads" = "Downloads ";
          "downloads" = "downloads ";
          "Music" = "Music 󰎋";
          "music" = "music 󰎋";
          "Pictures" = "Pictures  ";
          "pictures" = "pictures  ";
          "Videos" = "Videos  ";
          "videos" = "videos  ";
          "/tmp" = "/tmp  ";
        };
      };

      fill = {
        symbol = " ";
      };

      git_branch = {
        symbol = " ";
        style = "fg:green";
        format = "[$symbol$branch(:$remote_branch) ]($style)";
        truncation_length = 4;
        truncation_symbol = "…/";
      };

      git_status = {
        style = "fg:red";
        format = "([$conflicted$ahead_behind$diverged$staged$stashed$renamed$modified$untracked$deleted]($style) )";
        conflicted = " \${count}";
        ahead = "↑\${count}";
        behind = "↓\${count}";
        diverged = "󱓌 ↑\${ahead_count}↓\${behind_count}";
        untracked = "?\${count}";
        stashed = "●\${count}";
        modified = "!\${count}";
        renamed = ">\${count}";
        up_to_date = "[](green) ";
        staged = "\${count}";
        deleted = "✘\${count}";
      };

      git_metrics = {
        disabled = false;
        added_style = "green";
        deleted_style = "red";
        format = "([Σ$added]($added_style) )([✘$deleted]($deleted_style) )";
        ignore_submodules = false;
      };

      golang = {
        symbol = " ";
        style = "blue";
        format = "[\${symbol}(\${version})]($style)";
      };

      java = {
        symbol = "";
        style = "yellow";
        format = "[$symbol(\${version})($profile )]($style)";
      };

      jobs = {
        symbol = " ";
        style = "red";
        format = "[$symbol]($style)";
        number_threshold = 1;
      };

      kotlin = {
        symbol = " ";
        style = "blue";
        format = "[\${symbol}(\${version})]($style)";
      };

      lua = {
        symbol = " ";
        style = "blue";
        format = "[\${symbol}(\${version})]($style)";
      };

      nix_shell = {
        symbol = " ";
        style = "blue";
        format = "[\${symbol}($state)(\\($name\\))]($style)";
      };

      nodejs = {
        symbol = " ";
        style = "green";
        format = "[\${symbol}(\${version})]($style)";
      };

      os = {
        disabled = false;
        format = "[$symbol]($style) ";
        symbols = {
          Alpine = "[ ](fg:blue)";
          Android = "[ ](fg:green)";
          Arch = "[󰣇](fg:blue)";
          Debian = "[󰣚](fg:#d70a53)";
          Gentoo = "[](fg:blue)";
          Macos = "[](fg:white)";
          NixOS = "[](fg:blue)";
          openSUSE = "[](fg:#73ba25)";
          Raspbian = "[󰐿](fg:#C51A4A)";
          Redhat = "[󱄛](fg:#ee0000)";
          Ubuntu = "[](fg:#E95420)";
          Windows = "[󰍲](fg:#0078d7)";
        };
      };

      package = {
        symbol = "󰏗 ";
        style = "mauve";
        format = " [\${symbol}(\${version})]($style)";
      };

      python = {
        symbol = " ";
        style = "teal";
        format = "[\${symbol}(\${version}) ($virtualenv)]($style)";
      };

      ruby = {
        symbol = " ";
        style = "red";
        format = "[\${symbol}(\${version})]($style)";
      };

      rust = {
        symbol = " ";
        style = "peach";
        format = "[\${symbol}(\${version})]($style)";
      };

      shell = {
        disabled = true;
        fish_indicator = "󰈺 ";
        style = "cyan bold";
      };

      sudo = {
        disabled = false;
        symbol = " ";
        style = "bold red";
        format = "[$symbol]($style)";
      };

      swift = {
        symbol = " ";
        style = "peach";
        format = "[\${symbol}(\${version})]($style)";
      };

      time = {
        disabled = false;
        style = "cyan";
        format = "[$time]($style)";
        time_format = "%T";
        # utc_time_offset = "-5";
        # time_range = "10:00:00-14:00:00";
      };

      username = {
        show_always = true;
        style_user = "fg:text";
        style_root = "fg:text";
        format = "[ $user ]($style)";
      };

      zig = {
        symbol = " ";
        style = "yellow";
        format = "[$symbol($version )]($style)";
      };
    };
  };
}
