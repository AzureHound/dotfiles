{
  lib,
  self,
  config,
  ...
}:

let
  inherit (lib.modules) mkIf;
  inherit (self.lib) mkServiceOption;

  cfg = config.pixel.services.sonarr;
in

{
  options.pixel.services.sonarr = mkServiceOption "sonarr" {
    port = 3020;
    host = "0.0.0.0";
    domain = "shows.${config.networking.domain}";
  };

  config = mkIf cfg.enable {
    services = {
      sonarr = {
        inherit (cfg) enable;
        group = "media";
        settings.server = {
          inherit (cfg) port;
          bindaddress = cfg.host;
        };
      };

      nginx.virtualHosts.${cfg.domain}.locations."/".proxyPass = "http://127.0.0.1:${toString cfg.port}";
    };

    networking.firewall.allowedTCPPorts = [ cfg.port ];
  };
}
