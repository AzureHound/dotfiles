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

  cfg = config.pixel.services.vaultwarden;
in

{
  options.pixel.services.vaultwarden = mkServiceOption "vaultwarden" {
    port = 3013;
    domain = "vault.${rdomain}";
  };

  config = mkIf cfg.enable {
    sops.secrets = {
      vaultwarden-env = mkSecret {
        file = "vaultwarden";
        key = "env";
        owner = "vaultwarden";
        group = "vaultwarden";
      };
    };

    services = {
      vaultwarden = {
        enable = true;
        environmentFile = config.sops.secrets.vaultwarden-env.path;

        # https://github.com/dani-garcia/vaultwarden/blob/1.34.1/.env.template
        config = {
          DOMAIN = "https://${cfg.domain}";
          ROCKET_ADDRESS = "127.0.0.1";
          ROCKET_PORT = cfg.port;

          SIGNUPS_ALLOWED = false;
          # SIGNUPS_DOMAINS_WHITELIST = "${rdomain}";
          SIGNUPS_VERIFY = true;
          INVITATIONS_ALLOWED = true;

          SMTP_AUTH_MECHANISM = "Login";
          SMTP_FROM_NAME = "Vaultwarden";
          SMTP_HOST = "smtp.gmail.com";
          SMTP_PORT = 587;
          SMTP_SECURITY = "starttls";

          SHOW_PASSWORD_HINT = false;

          LOG_LEVEL = "warn";
          EXTENDED_LOGGING = true;
          USE_SYS_LOG = true;
        };
      };

      # https://github.com/dani-garcia/vaultwarden/wiki/Proxy-examples
      nginx.virtualHosts.${cfg.domain}.locations."/" = {
        proxyPass = "http://127.0.0.1:${toString cfg.port}";
        proxyWebsockets = true;
        extraConfig = ''
          proxy_pass_header Authorization;
        '';
      };
    };
  };
}
