{ pkgs, ... }:

{
  programs.aerospace = {
    enable = pkgs.stdenv.hostPlatform.isDarwin;

    launchd.enable = true;

    settings = {
      config-version = 2;
      auto-reload-config = true;

      enable-normalization-flatten-containers = true;
      enable-normalization-opposite-orientation-for-nested-containers = true;

      accordion-padding = 20;
      default-root-container-layout = "tiles";
      default-root-container-orientation = "auto";

      automatically-unhide-macos-hidden-apps = true;
      persistent-workspaces = [
        "1"
        "2"
        "3"
        "4"
      ];

      # focus-follows-mouse.enabled = true;
      key-mapping.preset = "qwerty";

      gaps = {
        inner.horizontal = 10;
        inner.vertical = 10;

        outer.left = 4;
        outer.bottom = 4;
        outer.top = 4;
        outer.right = 4;
      };

      mode.main.binding = {
        alt-slash = "layout tiles horizontal vertical";
        alt-comma = "layout accordion horizontal vertical";

        alt-h = "focus left";
        alt-j = "focus down";
        alt-k = "focus up";
        alt-l = "focus right";

        alt-shift-h = "move left";
        alt-shift-j = "move down";
        alt-shift-k = "move up";
        alt-shift-l = "move right";

        alt-ctrl-h = "join-with left";
        alt-ctrl-j = "join-with down";
        alt-ctrl-k = "join-with up";
        alt-ctrl-l = "join-with right";

        alt-left = "focus left";
        alt-down = "focus down";
        alt-up = "focus up";
        alt-right = "focus right";

        alt-shift-left = "move left";
        alt-shift-down = "move down";
        alt-shift-up = "move up";
        alt-shift-right = "move right";

        alt-ctrl-left = "join-with left";
        alt-ctrl-down = "join-with down";
        alt-ctrl-up = "join-with up";
        alt-ctrl-right = "join-with right";

        alt-minus = "resize smart -50";
        alt-equal = "resize smart +50";

        alt-tab = "workspace-back-and-forth";

        alt-1 = "workspace 1";
        alt-2 = "workspace 2";
        alt-3 = "workspace 3";
        alt-4 = "workspace 4";
        alt-5 = "workspace 5";
        alt-6 = "workspace 6";
        alt-7 = "workspace 7";
        alt-8 = "workspace 8";
        alt-9 = "workspace 9";
        alt-0 = "workspace 10";

        alt-shift-1 = "move-node-to-workspace --focus-follows-window 1";
        alt-shift-2 = "move-node-to-workspace --focus-follows-window 2";
        alt-shift-3 = "move-node-to-workspace --focus-follows-window 3";
        alt-shift-4 = "move-node-to-workspace --focus-follows-window 4";
        alt-shift-5 = "move-node-to-workspace --focus-follows-window 5";
        alt-shift-6 = "move-node-to-workspace --focus-follows-window 6";
        alt-shift-7 = "move-node-to-workspace --focus-follows-window 7";
        alt-shift-8 = "move-node-to-workspace --focus-follows-window 8";
        alt-shift-9 = "move-node-to-workspace --focus-follows-window 9";
        alt-shift-0 = "move-node-to-workspace --focus-follows-window 10";

        alt-e = "exec-and-forget open .";
        alt-f = "fullscreen";
        alt-w = "close --quit-if-last-window";
        alt-space = "layout floating tiling";

        alt-enter = "exec-and-forget open -a Ghostty";
        alt-shift-enter = "exec-and-forget open -a Terminal";

        alt-a = "mode app";
        alt-shift-semicolon = "mode service";
      };

      mode.app.binding = {
        esc = "mode main";
        enter = [
          "exec-and-forget open -a Ghostty"
          "mode main"
        ];
        m = [
          "exec-and-forget open -a Music"
          "mode main"
        ];
        s = [
          "exec-and-forget open -a Spotify"
          "mode main"
        ];
      };

      mode.service.binding = {
        esc = [
          "reload-config"
          "mode main"
        ];
        r = [
          "flatten-workspace-tree"
          "mode main"
        ];
        f = [
          "layout floating tiling"
          "mode main"
        ];
        backspace = [
          "close-all-windows-but-current"
          "mode main"
        ];
      };

      on-window-detected = [
        {
          "if".app-id = "com.apple.finder";
          run = [ "layout floating" ];
        }
        {
          "if".app-id = "com.apple.systempreferences";
          run = [ "layout floating" ];
        }

        {
          "if".app-id = "com.mitchellh.ghostty";
          run = [ "move-node-to-workspace 1" ];
        }
        {
          "if".app-id = "app.zen-browser.zen";
          run = [ "move-node-to-workspace 2" ];
        }
        {
          "if".app-id = "com.apple.Safari";
          run = [ "move-node-to-workspace 3" ];
        }
        {
          "if".app-id = "net.whatsapp.WhatsApp";
          run = [ "move-node-to-workspace 5" ];
        }
        {
          "if".app-id = "com.spotify.client";
          run = [ "move-node-to-workspace 7" ];
        }
      ];
    };
  };
}
