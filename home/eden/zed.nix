{ lib, config, ... }:

let
  inherit (lib.modules) mkIf;
in

{
  config = mkIf config.pixel.profiles.development.enable {
    programs.zed-editor = {
      enable = true;

      extensions = [
        "autocorrect"
        "catppuccin-icons"
        "color-highlight"
        "dockerfile"
        "html"
        "lua"
        "marksman"
        "nix"
        "powershell"
        "toml"
      ];

      userSettings = {
        agent = {
          enable_feedback = false;
          model_parameters = [ ];
          play_sound_when_agent_done = "always";
          use_modifier_to_send = true;
        };
        always_treat_brackets_as_autoclosed = true;
        auto_update = false;
        autosave = {
          after_delay = {
            milliseconds = 1000;
          };
        };
        buffer_font_family = "JetBrainsMono Nerd Font";
        buffer_font_size = 17.0;
        calls = {
          mute_on_join = true;
        };
        close_on_file_delete = true;
        collaboration_panel = {
          button = false;
          dock = "right";
        };
        diagnostics = {
          inline = {
            enabled = true;
          };
        };
        disable_ai = true;
        experimental = {
          theme_overrides = {
            background = "#24273a";
            border.variant = "#24273a";
            editor.active_line_number = "#f4dbd6";
            panel.background = "#24273a";
            scrollbar.track.background = "#24273a";
            status_bar.background = "#24273a";
            text.accent = "#8aadf4";
            title_bar.background = "#24273a";
          };
        };
        file_finder = {
          modal_max_width = "large";
        };
        icon_theme = "Catppuccin Macchiato";
        indent_guides = {
          coloring = "indent_aware";
        };
        inlay_hints = {
          show_background = true;
        };
        minimap = {
          show = "auto";
        };
        on_last_window_closed = "quit_app";
        outline_panel = {
          auto_fold_dirs = false;
        };
        prettier = {
          allowed = true;
        };
        project_panel = {
          hide_root = true;
          scrollbar = {
            show = "system";
          };
          starts_open = false;
        };
        relative_line_numbers = "wrapped";
        restore_on_startup = "launchpad";
        search = {
          center_on_match = true;
          regex = true;
        };
        status_bar = {
          experimental = {
            show = false;
          };
        };
        sticky_scroll = {
          enabled = true;
        };
        tab_bar = {
          show = false;
          show_nav_history_buttons = false;
        };
        tabs = {
          file_icons = true;
        };
        telemetry = {
          diagnostics = false;
          metrics = false;
        };
        terminal = {
          keep_selection_on_copy = false;
          shell = {
            program = "zsh";
          };
        };
        theme = {
          dark = "Catppuccin Macchiato (blue)";
          light = "Catppuccin Macchiato (blue)";
        };
        title_bar = {
          show_branch_name = false;
          show_project_items = false;
          show_sign_in = false;
          show_user_menu = false;
        };
        toolbar = {
          breadcrumbs = false;
          quick_actions = false;
        };
        ui_font_family = "Maple Mono";
        ui_font_size = 18.0;
        vim_mode = true;
      };
    };

    home.shellAliases = {
      zed = "zeditor";
    };
  };
}
