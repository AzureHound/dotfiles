{
  lib,
  pkgs,
  config,
  ...
}:

let
  inherit (lib.modules) mkIf;
in

{
  programs.qutebrowser = {
    loadAutoconfig = true;

    greasemonkey = [
      (pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/tumpio/gmscripts/master/Endless_Google/egoogle.user.js";
        hash = "sha256-LgHaZkq+VLYczlAqd+0Pe+mP11z3R35833CADoOI5NI=";
      })

      (pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/erkserkserks/h264ify/master/src/inject/inject.js";
        hash = "sha256-TK7qlWQPreV4CjFxpS519sbZZ2Dw647XtUo+Kzlq13I=";
      })

      (pkgs.fetchurl {
        url = "https://update.greasyfork.org/scripts/453320/Simple%20Sponsor%20Skipper.user.js";
        hash = "sha256-/Q4Fc7OIFVrtbySei57831Z1VYTRcmMR9b+ORYw40h8=";
      })
    ];

    quickmarks = {
      startpage = "file://${config.home.homeDirectory}/Developer/Startpage/index.html";
      aw = "https://wiki.archlinux.org/";
      apkg = "https://archlinux.org/packages/";
      gh = "https://github.com/";
      yt = "https://youtube.com/";
    };

    searchEngines = {
      DEFAULT = "https://duckduckgo.com/?q={}";
    };

    settings = {
      # url.start_pages = [ "file://${config.home.homeDirectory}/Developer/Startpage/index.html" ];

      colors.webpage.darkmode = {
        enabled = true;
        policy.images = "never";
        algorithm = "lightness-cielab";
      };

      fonts = {
        default_size = "12pt";
        default_family = "JetBrainsMono Nerd Font";
        downloads = "12pt JetBrainsMono Nerd Font";
        completion.entry = "12pt JetBrainsMono Nerd Font";
        messages.info = "12pt JetBrainsMono Nerd Font";
        messages.error = "12pt JetBrainsMono Nerd Font";
        messages.warning = "12pt JetBrainsMono Nerd Font";
        prompts = "12pt JetBrainsMono Nerd Font";
        statusbar = "12pt JetBrainsMono Nerd Font";
        web.family = {
          sans_serif = "Josefin Sans";
          serif = "Josefin Sans";
          fixed = "JetBrainsMono Nerd Font";
        };
      };

      content = {
        user_stylesheets = [ "${config.xdg.configHome}/qutebrowser/styles/fonts.css" ];

        desktop_capture = true;
        # window.transparent = true;

        blocking.enabled = true;

        webgl = false;
        geolocation = false;
        cookies.store = true;
        canvas_reading = false;
        cookies.accept = "all";
        private_browsing = false;
        webrtc_ip_handling_policy = "default-public-interface-only";
      };

      auto_save.session = true;

      completion = {
        shrink = true;
        open_categories = [
          "searchengines"
          "quickmarks"
          "bookmarks"
          "history"
          "filesystem"
        ];
      };

      tabs = {
        show = "never";
        indicator.width = 0;
        title.format = "{audio}{current_title}";
      };

      statusbar.show = "in-mode";

      scrolling = {
        bar = "when-searching";
        smooth = false;
      };
    };

    extraConfig = ''
      c.tabs.padding = {"top": 2, "bottom": 3, "left": 6, "right": 6}
    '';
  };

  xdg.configFile = mkIf config.programs.qutebrowser.enable {
    "qutebrowser/styles/fonts.css".text = ''
      * {
        font-family: "Josefin Sans" !important;
      }

      code,
      pre,
      tt,
      kbd,
      samp {
        font-family: "JetBrainsMono Nerd Font" !important;
      }
    '';
  };
}
