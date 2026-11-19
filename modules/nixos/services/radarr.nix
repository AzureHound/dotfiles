{
  lib,
  self,
  config,
  ...
}:

let
  inherit (lib.modules) mkIf;
  inherit (self.lib) mkService;

  cfg = config.pixel.services.radarr;
in

{
  imports = [
    (mkService "radarr" {
      port = 3021;
      host = "0.0.0.0";
      domain = "movies.${config.networking.domain}";
    })
  ];

  config = mkIf cfg.enable {
    services = {
      radarr = {
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
