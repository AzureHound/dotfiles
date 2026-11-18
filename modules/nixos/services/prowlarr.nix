{
  lib,
  self,
  config,
  ...
}:

let
  inherit (lib.modules) mkIf;
  inherit (self.lib) mkServiceOption;

  cfg = config.pixel.services.prowlarr;
in

{
  options.pixel.services.prowlarr = mkServiceOption "prowlarr" {
    port = 3022;
    host = "0.0.0.0";
    domain = "indexers.${config.networking.domain}";
  };

  config = mkIf cfg.enable {
    services = {
      prowlarr = {
        enable = true;
        settings.server = {
          inherit (cfg) port;
          bindaddress = cfg.host;
        };
      };

      nginx.virtualHosts.${cfg.domain}.locations."/".proxyPass = "http://127.0.0.1:${toString cfg.port}";
    };

    networking.firewall.allowedTCPPorts = [ cfg.port ];

    systemd.services.prowlarr.serviceConfig = {
      User = "prowlarr";
      Group = "media";
    };
  };
}
