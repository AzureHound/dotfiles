{ config, mkCfgLink, ... }:

{
  services.espanso = {
    inherit (config.pixel.profiles.graphical) enable;

    x11Support = false;

    configs = {
      default = {
        toggle_key = "RIGHT_CTRL";
        search_shortcut = "CTRL+SHIFT+SPACE";
        show_notifications = false;
      };
    };

    matches = {
      base = {
        matches = [
          # Text Replacement
          {
            trigger = ":email";
            replace = "eyesashik@gmail.com";
          }
          {
            trigger = ":ai";
            replace = "Provide detailed, direct answers using as few words as possible while being less verbose.";
          }

          # Currency Symbols
          {
            trigger = ":eur";
            replace = "€";
          }
          {
            trigger = ":gbp";
            replace = "£";
          }
          {
            trigger = ":usd";
            replace = "$";
          }
          {
            trigger = ":jpy";
            replace = "¥";
          }
          {
            trigger = ":inr";
            replace = "₹";
          }
          {
            trigger = ":btc";
            replace = "฿";
          }
          {
            trigger = ":eth";
            replace = "Ξ";
          }
          {
            triggers = [
              ":(c)"
              ":copyright:"
            ];
            replace = "©";
          }

          # Print the current time {24hr}
          {
            trigger = ":time";
            replace = "{{time}}";
            vars = [
              {
                name = "time";
                type = "date";
                params = {
                  format = "%H:%M";
                };
              }
            ];
          }

          # Print the current date
          {
            trigger = ":date";
            replace = "{{mydate}}";
            vars = [
              {
                name = "mydate";
                type = "date";
                params = {
                  format = "%d/%m/%Y";
                };
              }
            ];
          }

          # Print public IP address
          {
            trigger = ":ip";
            replace = "{{output}}";
            vars = [
              {
                name = "output";
                type = "shell";
                params = {
                  cmd = "curl 'https://api.ipify.org'";
                };
              }
            ];
          }
        ];
      };
    };
  };

  xdg.configFile = mkCfgLink (
    map (f: "espanso/match/${f}") [
      "arrows-&-pointers.yml"
      "auto-correct.yml"
      "case.yml"
      "currencies.yml"
      "emojis.yml"
      "git.yml"
      "lorem.yml"
      "wtc.yml"
      "wttr.yml"
    ]
  );
}
