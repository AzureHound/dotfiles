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

  cfg = config.pixel.services.radicale;
in

{
  options.pixel.services.radicale = mkServiceOption "radicale" {
    port = 5232;
    domain = "cal.${rdomain}";
  };

  config = mkIf cfg.enable {
    sops.secrets.radicale-htpasswd = mkSecret {
      file = "radicale";
      key = "htpasswd";
      owner = "radicale";
      group = "radicale";
    };

    services = {
      radicale = {
        enable = true;

        settings = {
          server = {
            hosts = [ "127.0.0.1:${toString cfg.port}" ];
          };
          auth = {
            type = "htpasswd";
            htpasswd_filename = config.sops.secrets.radicale-htpasswd.path;
            htpasswd_encryption = "plain";
          };
        };
      };

      nginx.virtualHosts.${cfg.domain}.locations."/" = {
        proxyPass = "http://127.0.0.1:${toString cfg.port}";
        extraConfig = ''
          proxy_set_header X-Script-Name /;
          proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
          proxy_pass_header Authorization;
        '';
      };
    };
  };
}
