{
  lib,
  self,
  config,
  ...
}:

let
  inherit (lib.modules) mkIf;
  inherit (self.lib) mkSecret journalJail mkService;

  # https://github.com/dani-garcia/vaultwarden/wiki/Fail2Ban-Setup
  jail =
    failregex:
    journalJail "vaultwarden" [ failregex ] {
      maxretry = 3;
      bantime = 14400;
      findtime = 14400;
    };

  rdomain = config.networking.domain;

  cfg = config.pixel.services.vaultwarden;
in

{
  imports = [
    (mkService "vaultwarden" {
      port = 3013;
      domain = "vault.${rdomain}";
    })
  ];

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
      fail2ban.jails = {
        vaultwarden = jail ''^.*?Username or password is incorrect\. Try again\. IP: <ADDR>\. Username:.*$'';
        vaultwarden-admin = jail ''^.*?Invalid admin token\. IP: <ADDR>.*$'';
      };

      vaultwarden = {
        enable = true;
        environmentFile = config.sops.secrets.vaultwarden-env.path;

        # https://github.com/dani-garcia/vaultwarden/blob/1.37.5/.env.template
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
