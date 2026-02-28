{
  lib,
  self,
  config,
  ...
}:

let
  inherit (lib.modules) mkIf;
  inherit (self.lib) mkServiceOption mkSecret;

  rdomain = config.networking.domain;

  cfg = config.pixel.services.searx;
in

{
  options.pixel.services.searx = mkServiceOption "searx" {
    port = 8888;
    domain = "search.${rdomain}";
  };

  config = mkIf cfg.enable {
    sops.secrets.searx-env = mkSecret {
      file = "searx";
      key = "env";
    };

    services = {
      searx = {
        enable = true;

        redisCreateLocally = true;
        environmentFile = config.sops.secrets.searx-env.path;

        settings = {
          use_default_settings = true;

          general = {
            debug = false;
            contact_url = false;
            donation_url = false;
            enable_metrics = false;
            privacypolicy_url = false;
          };

          search = {
            safe_search = 0;
            autocomplete = "duckduckgo";
            formats = [ "html" ];
          };

          server = {
            bind_address = "127.0.0.1";
            inherit (cfg) port;
            secret_key = "@SEARXNG_SECRET@";
            limiter = false;
            image_proxy = true;
            base_url = "https://${cfg.domain}/";
          };

          ui = {
            infinite_scroll = true;
            default_theme = "simple";
            center_alignment = true;
            results_on_new_tab = true;
            theme_args.simple_style = "auto";
            hotkeys = "vim";
            url_formatting = "full";
          };

          plugins = {
            "searx.plugins.tor_check.SXNGPlugin".active = true;
          };
        };
      };

      nginx.virtualHosts.${cfg.domain}.locations."/".proxyPass = "http://127.0.0.1:${toString cfg.port}";
    };
  };
}
