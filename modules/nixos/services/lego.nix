{
  lib,
  self,
  config,
  ...
}:

let
  inherit (lib.modules) mkIf;
  inherit (self.lib) mkSecret;
in

{
  config = mkIf config.pixel.services.nginx.enable {
    sops.secrets = {
      lego-duckdns = mkSecret {
        file = "lego";
        key = "duckdns";
        owner = "acme";
        group = "acme";
      };
    };

    users = {
      users.acme = {
        isSystemUser = true;
        group = "acme";
      };
      groups.acme = { };
    };

    security.acme = {
      acceptTerms = true;
      defaults = {
        email = "azurehound.issue288@slmail.me";
        dnsProvider = "duckdns";
        environmentFile = config.sops.secrets.lego-duckdns.path;
      };

      certs."${config.pixel.services.nginx.domain}" = {
        domain = config.pixel.services.nginx.domain;
        extraDomainNames = [ "*.${config.pixel.services.nginx.domain}" ];
      };
    };
  };
}
