{
  lib,
  config,
  inputs,
  ...
}:

let
  inherit (lib.modules) mkIf;
in

{
  imports = [
    inputs.noctalia.homeModules.default
  ];

  sops.secrets.ha_token = { };

  programs = {
    noctalia = {
      systemd.enable = true;

      settings = {
        bar.default = {
          auto_hide = true;
          capsule = true;
          concave_edge_corners = false;
          end = [
            "media"
            "tray"
            "clipboard"
            "notifications"
            "network"
            "bluetooth"
            "volume"
            "brightness"
            "battery"
            "control-center"
            "session"
          ];
          margin_ends = 0;
          radius = 0;
          reserve_space = false;
          shadow = false;
          show_on_workspace_switch = false;
          smart_auto_hide = false;
          start = [
            "launcher"
            "workspaces"
            "wallpaper"
          ];
        };

        battery = {
          warning_threshold = 30;
        };

        bluetooth = {
          connect_when_enabled = true;
          connection_notifications = true;
        };

        brightness = {
          enable_ddcutil = true;
          minimum_brightness = 0.19999999552965164;
          sync_all_monitors = true;
        };

        calendar = {
          enabled = true;
        };

        control_center = {
          hidden_tabs = [
            "monitor"
            "system"
            "power"
            "calendar"
            "notifications"
          ];
          show_avatar_border = false;
          show_shortcut_labels = false;
          calendar = {
            show_week_numbers = true;
          };
          shortcuts = [
            { type = "wifi"; }
            { type = "bluetooth"; }
            { type = "caffeine"; }
            { type = "nightlight"; }
            { type = "wallpaper"; }
            { type = "notification"; }
          ];
        };

        desktop_widgets = {
          enabled = false;
          schema_version = 2;
          widget_order = [ ];
          grid = {
            cell_size = 16;
            major_interval = 4;
            visible = true;
          };
          widget = { };
        };

        dock = {
          active_monitor_only = true;
          auto_hide = true;
          concave_edge_corners = false;
          enabled = true;
          reserve_space = false;
          shadow = false;
          show_dots = true;
          smart_auto_hide = false;
        };

        hot_corners = {
          enabled = true;
          top_left.action = "launcher";
          top_right.action = "window_switcher";
        };

        idle = {
          behavior_order = [
            "lock"
            "screen-off"
            "lock-and-suspend"
          ];
          behavior = {
            lock = {
              action = "lock";
              enabled = true;
              timeout = 600.0;
            };
            lock-and-suspend = {
              action = "lock_and_suspend";
              enabled = true;
              timeout = 900.0;
            };
            screen-off = {
              action = "screen_off";
              enabled = true;
              timeout = 660.0;
            };
          };
        };

        location = {
          address = "Agartala, IN";
          custom_schedule = true;
          sunrise = "06:00";
          sunset = "17:00";
        };

        lockscreen = {
          transition = [
            "fade"
            "wipe"
            "zoom"
          ];
          wallpaper = "/home/eden/Developer/Wallpapers/flowers.png";
        };

        lockscreen_widgets = {
          schema_version = 2;
          widget_order = [ "lockscreen-login-box@eDP-1" ];
          grid = {
            cell_size = 16;
            major_interval = 4;
            visible = true;
          };
          widget."lockscreen-login-box@eDP-1" = {
            box_height = 196.0;
            box_width = 810.0;
            cx = 640.0;
            cy = 538.0;
            output = "eDP-1";
            placement_height = 720.0;
            placement_width = 1280.0;
            rotation = 0.0;
            type = "login_box";
            settings = {
              background_color = "surface_container";
              background_opacity = 0.88;
              background_radius = 12.0;
              center_password_text = false;
              input_opacity = 1.0;
              input_radius = 6.0;
              layout = "regular";
              show_caps_lock = true;
              show_keyboard_layout = true;
              show_login_button = true;
              show_media = true;
              show_media_controls = true;
              show_password_reveal = true;
              show_session_buttons = true;
              show_unlock_hint = true;
              show_weather = true;
            };
          };
        };

        nightlight = {
          enabled = true;
        };

        osd = {
          border = false;
          follow_focused_output = true;
          position = "bottom_center";
          position_vertical = "bottom_center";
        };

        plugins = {
          enabled = [
            "noctalia/screen_recorder"
            "pozzoo/hassio"
          ];
        };

        plugin_settings = {
          "pozzoo/hassio" = {
            ha_token = config.sops.placeholder.ha_token;
            ha_url = "http://10.10.0.4:8123";
          };
        };

        shell = {
          avatar_path = "/home/eden/.face";
          button_borders = false;
          card_borders = false;
          corner_radius_scale = 2.0;
          external_ip_enabled = true;
          font_family = "JetBrainsMono Nerd Font";
          polkit_agent = true;
          popup_shadows = false;
          screen_time_enabled = true;
          show_close_buttons = false;
          show_location = false;
          animation = {
            enabled = false;
          };
          launcher = {
            categories = false;
            layout = "simple";
          };
          panel = {
            control_center_placement = "floating";
            session_placement = "floating";
            session_position = "center";
            shadow = false;
            wallpaper_placement = "floating";
          };
          session = {
            show_shortcuts = false;
          };
        };

        theme = {
          builtin = "Catppuccin";
          custom_palette = "CatppuccinMacchiato";
          mode = "dark";
          source = "custom";
          wallpaper_scheme = "m3-content";
          templates = {
            enable_builtin_templates = false;
          };
        };

        wallpaper = {
          directory = "/home/eden/Developer/Wallpapers";
          transition = [
            "disc"
            "fade"
            "pixel"
          ];
          transition_on_startup = true;
          default.path = "/home/eden/Developer/Wallpapers/flower-garden.png";
          # monitors."eDP-1".path = "/home/eden/Developer/Wallpapers/architecture.jpg";
        };

        widget = {
          battery = {
            peek = true;
          };
          bluetooth.enabled = false;
          brightness.enabled = false;
          clipboard.enabled = true;
          control-center = {
            glyph = "brand-snowflake";
            icon_color = "#8AADF4";
          };
          launcher = {
            enabled = false;
            glyph = "rocket";
          };
          media = {
            enabled = true;
            hide_artist = true;
            hide_when_idle = true;
            hide_when_no_media = true;
            peek = true;
            rotate_album_art = true;
            title_scroll = "on_hover";
          };
          network.enabled = false;
          notifications.enabled = true;
          volume.enabled = false;
          wallpaper.enabled = false;
        };
      };
    };

    quickshell.enable = config.programs.noctalia.enable;
  };

  home.file.".config/noctalia/palettes/CatppuccinMacchiato.json" = mkIf config.programs.noctalia.enable {
    text = ''
      {
        "version": 2,
        "dark": {
          "primary": "#eed49f",
          "on_primary": "#24273a",
          "secondary": "#f4dbd6",
          "on_secondary": "#24273a",
          "tertiary": "#f0c6c6",
          "on_tertiary": "#24273a",
          "error": "#ed8796",
          "on_error": "#24273a",
          "surface": "#24273a",
          "on_surface": "#cad3f5",
          "surface_container": "#363a4f",
          "on_surface_variant": "#a5adcb",
          "outline_variant": "#6e738d",
          "shadow": "#181926",
          "hover": "#494d64",
          "on_hover": "#cad3f5",
          "terminal": {
            "normal": {
              "black": "#494d64",
              "red": "#ed8796",
              "green": "#a6da95",
              "yellow": "#eed49f",
              "blue": "#8aadf4",
              "magenta": "#f5bde6",
              "cyan": "#8bd5ca",
              "white": "#b8c0e0"
            },
            "bright": {
              "black": "#5b6078",
              "red": "#ed8796",
              "green": "#a6da95",
              "yellow": "#eed49f",
              "blue": "#8aadf4",
              "magenta": "#f5bde6",
              "cyan": "#8bd5ca",
              "white": "#a5adcb"
            },
            "foreground": "#cad3f5",
            "background": "#24273a",
            "selection_fg": "#cad3f5",
            "selection_bg": "#5b6078",
            "cursor_text": "#24273a",
            "cursor": "#f4dbd6"
          }
        },
        "light": {
          "primary": "#dc8a78",
          "on_primary": "#eff1f5",
          "secondary": "#dd7878",
          "on_secondary": "#eff1f5",
          "tertiary": "#df8e1d",
          "on_tertiary": "#eff1f5",
          "error": "#d20f39",
          "on_error": "#eff1f5",
          "surface": "#eff1f5",
          "on_surface": "#4c4f69",
          "surface_container": "#ccd0da",
          "on_surface_variant": "#6c6f85",
          "outline_variant": "#9ca0b0",
          "shadow": "#dce0e8",
          "hover": "#bcc0cc",
          "on_hover": "#4c4f69",
          "terminal": {
            "normal": {
              "black": "#5c5f77",
              "red": "#d20f39",
              "green": "#40a02b",
              "yellow": "#df8e1d",
              "blue": "#1e66f5",
              "magenta": "#ea76cb",
              "cyan": "#179299",
              "white": "#acb0be"
            },
            "bright": {
              "black": "#6c6f85",
              "red": "#d20f39",
              "green": "#40a02b",
              "yellow": "#df8e1d",
              "blue": "#1e66f5",
              "magenta": "#ea76cb",
              "cyan": "#179299",
              "white": "#bcc0cc"
            },
            "foreground": "#4c4f69",
            "background": "#eff1f5",
            "selection_fg": "#4c4f69",
            "selection_bg": "#acb0be",
            "cursor_text": "#eff1f5",
            "cursor": "#dc8a78"
          }
        }
      }
    '';
  };
}