{
  plugins = {
    blink-cmp = {
      enable = true;
      lazyLoad.settings.event = [
        "InsertEnter"
        "CmdlineEnter"
      ];

      setupLspCapabilities = true;
      settings = {
        appearance = {
          nerd_font_variant = "mono";
          use_nvim_cmp_as_default = false;
          kind_icons.__raw = "(vim.g.icons or {}).kinds or {}";
        };

        cmdline = {
          enabled = true;
          keymap.preset = "cmdline";
          completion = {
            ghost_text.enabled = true;
            menu.auto_show = true;
          };
        };

        completion = {
          accept.auto_brackets.enabled = true;

          documentation = {
            auto_show = true;
            auto_show_delay_ms = 200;
          };

          ghost_text.enabled = true;

          menu = {
            draw = {
              treesitter = [ "lsp" ];
              columns = [
                { __unkeyed-1 = "label"; }
                { __unkeyed-1 = "kind_icon"; }
              ];
            };
          };

          trigger = {
            prefetch_on_insert = true;
            show_on_backspace = true;
          };
        };

        signature = {
          enabled = true;
        };
        snippets.preset = "default";

        sources = {
          default = [
            "lsp"
            "path"
            "snippets"
            "buffer"
            "lazydev"
            "dictionary"
            # "emoji"
            "git"
            "thesaurus"
            "words"
          ];
          per_filetype = {
            lua = [
              "lsp"
              "path"
              "snippets"
              "buffer"
              "lazydev"
            ];
            text = [ "dictionary" ];
          };
          providers = {
            dictionary = {
              module = "blink-cmp-dictionary";
              name = "Dict";
              score_offset = 100;
              min_keyword_length = 3;
              opts = { };
            };
            emoji = {
              module = "blink-emoji";
              name = "Emoji";
              score_offset = 15;
              opts = {
                insert = true;
              };
            };
            git = {
              module = "blink-cmp-git";
              name = "git";
              score_offset = 100;
              opts = {
                commit = { };
                git_centers = {
                  git_hub = { };
                };
              };
            };
            lazydev = {
              name = "LazyDev";
              module = "lazydev.integrations.blink";
              score_offset = 100;
            };
            thesaurus = {
              name = "blink-cmp-words";
              module = "blink-cmp-words.thesaurus";
              opts = {
                score_offset = 0;
                definition_pointers = [
                  "!"
                  "&"
                  "^"
                ];
                similarity_pointers = [
                  "&"
                  "^"
                ];
                similarity_depth = 2;
              };
            };
            words = {
              name = "blink-cmp-words";
              module = "blink-cmp-words.dictionary";
              opts = {
                dictionary_search_threshold = 3;
                score_offset = 0;
                definition_pointers = [
                  "!"
                  "&"
                  "^"
                ];
              };
            };
          };
        };

        keymap = {
          preset = "enter";
          "<C-y>" = [ "select_and_accept" ];
          "<Tab>" = [
            "snippet_forward"
            "fallback"
          ];
          "<S-Tab>" = [
            "snippet_backward"
            "fallback"
          ];
        };
      };
    };

    nvim-snippets = {
      enable = true;
      settings = {
        friendly_snippets = true;
        create_cmp_source = false;
      };
    };

    # Community Addons
    blink-cmp-dictionary.enable = true;
    blink-cmp-git.enable = true;
    blink-cmp-words.enable = true;
    blink-emoji.enable = true;
  };
}
