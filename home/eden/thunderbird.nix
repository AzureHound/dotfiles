{
  pkgs,
  name,
  inputs,
  ...
}:

let
  extensions = inputs.nur.legacyPackages.${pkgs.stdenv.hostPlatform.system}.repos.rycee.thunderbird-addons;
in

{
  programs.thunderbird = {
    profiles.${name} = {
      isDefault = true;

      extensions = with extensions; [ html-source-editor ];

      search = {
        force = true;
        default = "ddg";

        order = [
          "ddg"
          "google"
        ];

        engines = {
          "bing".metaData.hidden = true;
          "wikipedia".metaData.hidden = true;
        };
      };

      settings = {
        "browser.display.use_document_fonts" = 0;
        "browser.download.dir" = "/home/${name}/Downloads/Mail";
        "browser.download.downloadDir" = "/home/${name}/Downloads/Mail";
        "browser.download.folderList" = 2;
        "browser.download.useDownloadDir" = true;
        "datareporting.healthreport.uploadEnabled" = false;
        "font.name.monospace.x-western" = "JetBrainsMono Nerd Font";
        "font.name.sans-serif.x-western" = "Josefin Sans";
        "font.name.serif.x-western" = "Josefin Sans";
        "layout.css.always_underline_links" = true;
        "mail.SpellCheckBeforeSend" = true;
        "mail.citation_color" = "#8aadf4";
        "mail.close_message_window.on_delete" = true;
        "mail.compose.add_link_preview" = true;
        "mail.e2ee.auto_disable" = true;
        "mail.e2ee.auto_enable" = true;
        "mail.spam.manualMark" = true;
        "mail.tabs.drawInTitlebar" = false;
        "mailnews.mark_message_read.delay" = true;
        "mailnews.mark_message_read.delay.interval" = 6;
        "mailnews.message_display.disable_remote_image" = false;
        "mailnews.start_page.enabled" = false;
        "messenger.options.messagesStyle.variant" = "Dark";
        "network.trr.mode" = 5;
        "privacy.globalprivacycontrol.enabled" = true;
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
      };

      userChrome = ''
        #status-bar {
          display: none !important;
        }
      '';
    };
  };

  # Theme
  catppuccin.thunderbird = {
    accent = "lavender";
    profile = name;
  };
}
