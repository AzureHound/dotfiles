{
  lib,
  pkgs,
  config,
  mkCfgLink,
  ...
}:

let
  inherit (lib.modules) mkIf;
in

{
  config = mkIf (config.pixel.profiles.graphical.enable && pkgs.stdenv.hostPlatform.isLinux) {
    programs = {
      neomutt = {
        enable = true;

        editor = "nvim +':set textwidth=0'";

        sidebar = {
          enable = true;
          width = 26;
          shortPath = true;
          format = "%B%?F? [%F]?%* %?N?%N/? %?S?%S?";
        };

        settings = {
          markers = "no";
          charset = ''"utf-8"'';
          color_directcolor = "no";
          attach_save_dir = "~/Downloads/Mail";
          mailcap_path = "~/.config/neomutt/mailcap";
          index_format = ''"%4C %zc%zs%zt  %-35.35L  %@attachment_info@  %?M?~(%M)&? %-30.100s %> %?Y?%Y&? %4c  %{%a %d %h %H:%M} "'';

          sidebar_visible = "no";
          pager_stop = "yes";
          menu_scroll = "yes";
          pager_format = ''" %n %zc | %T %s%* 󰃭 %{!%d %b · %H:%M} %?X? |  %X |? %P 󰦨 "'';
          wait_key = "no";

          smart_wrap = "yes";
          reflow_wrap = "120";
          reflow_text = "yes";

          compose_format = ''"-- NeoMutt: Compose [Approx. msg size: %l Atts: %a]%>-"'';
          attach_format = ''"%u%D%I  %t%4n %T%.40d%> ? %5s · %.12m/%.12M, %.6e%?C?, %C?, %s "'';
          folder_format = ''"%4C %t %f"'';
          date_format = ''"%d/%m/%y at %H:%M"'';

          status_chars = ''"—+#~"'';
          status_on_top = "no";
          status_format = ''"%D %?u? %u ?%?R? %R | ? %m %?d? %d ?%?t? %t ?%?F? %F ?%?p?󰏪 %p? \n  \n"'';
          ts_status_format = ''"mutt %m messages%?n?, %n new?"'';

          crypt_chars = ''"󰒘"'';
          hidden_tags = ''"unread,draft,flagged,passed,replied,attachment,signed,encrypted"'';
        };

        extraConfig = ''
          auto_view text/html text/calendar
          alternative_order text/calendar text/plain text/enriched text/html text/*

          index-format-hook attachment_info '~A' "   "
          index-format-hook attachment_info '~X 1' "  "
          index-format-hook attachment_info '=B text/calendar' "   "
          index-format-hook attachment_info '=B text/calendar ~X 1' '  '

          # set to_chars = "     󰦨 "
          # set flag_chars = "     "
          # set status_chars = "    "

          tag-transforms "replied" " " \
                         "encrypted" "󰒘 " \
                         "signed" " " \
                         "attachment" "" \

          tag-formats "replied" "GR" \
                      "encrypted" "GE" \
                      "signed" "GS" \
                      "attachment" "GA" \

          source ~/.config/neomutt/binds
          source ~/.config/neomutt/theme

          unmailboxes *

          macro index,pager <f2> "<enter-command>unmailboxes *<enter><enter-command>set folder=\"${config.xdg.dataHome}/mail/gmail\"<enter><enter-command>mailboxes \`find ${config.xdg.dataHome}/mail/gmail -type d -name cur | sed 's|/cur$||' | sed 's/.*/\"&\"/' | tr '\\n' ' '\`<enter><change-folder>!<enter>" "Switch to Gmail"
          macro index,pager <f3> "<enter-command>unmailboxes *<enter><enter-command>set folder=\"${config.xdg.dataHome}/mail/icloud\"<enter><enter-command>mailboxes \`find ${config.xdg.dataHome}/mail/icloud -type d -name cur | sed 's|/cur$||' | sed 's/.*/\"&\"/' | tr '\\n' ' '\`<enter><change-folder>!<enter>" "Switch to iCloud"

          set folder = "${config.xdg.dataHome}/mail/gmail"
          mailboxes `find ${config.xdg.dataHome}/mail/gmail -type d -name cur | sed 's|/cur$||' | sed 's/.*/"&"/' | tr '\n' ' '`
        '';
      };

      mbsync.enable = true;
      msmtp.enable = true;
      notmuch.enable = true;
    };

    services.mbsync = {
      enable = true;
      frequency = "0/6:00:00";
      configFile = "${config.xdg.configHome}/isync/isyncrc";
    };

    accounts.email = {
      maildirBasePath = "${config.xdg.dataHome}/mail";

      accounts = {
        gmail = {
          primary = true;
          flavor = "gmail.com";
          address = "eyesashik@gmail.com";
          userName = "eyesashik@gmail.com";
          realName = "Ashik";
          passwordCommand = [
            "cat"
            config.sops.secrets."mail/gmail".path
          ];
          folders = {
            inbox = "Inbox";
            sent = "[Gmail]/Sent Mail";
            drafts = "[Gmail]/Drafts";
            trash = "[Gmail]/Trash";
          };
          neomutt.enable = true;
          msmtp.enable = true;
          notmuch = {
            enable = true;
            neomutt.virtualMailboxes = [ ];
          };
          mbsync = {
            enable = true;
            create = "both";
            expunge = "both";
          };
        };

        icloud = {
          address = "eyesashik@icloud.com";
          userName = "eyesashik@icloud.com";
          realName = "Ashik";
          passwordCommand = [
            "cat"
            config.sops.secrets."mail/icloud".path
          ];
          folders = {
            inbox = "Inbox";
            sent = "Sent Messages";
            drafts = "Drafts";
            trash = "Deleted Messages";
          };
          neomutt.enable = true;
          msmtp.enable = true;
          notmuch = {
            enable = true;
            neomutt.virtualMailboxes = [ ];
          };
          mbsync = {
            enable = true;
            create = "both";
            expunge = "both";
          };
          imap = {
            host = "imap.mail.me.com";
            port = 993;
            tls.enable = true;
          };
          smtp = {
            host = "smtp.mail.me.com";
            port = 587;
            tls.useStartTls = true;
          };
        };
      };
    };

    home = {
      sessionVariables = {
        MBSYNCRC = "${config.xdg.configHome}/isync/isyncrc";
        NOTMUCH_CONFIG = "${config.xdg.configHome}/notmuch/default/config";
      };

      shellAliases = {
        mbsync = "mbsync -c \"$MBSYNCRC\"";
      };
    };

    xdg.configFile =
      mkCfgLink (
        map (f: "neomutt/${f}") [
          "binds"
          "mailcap"
          "scripts"
          "theme"
        ]
      )
      // {
        "isyncrc".target = "isync/isyncrc";
      };

    sops.secrets = {
      "mail/gmail" = { };
      "mail/icloud" = { };
    };
  };
}
