{
  lib,
  self,
  config,
  ...
}:

let
  inherit (lib.modules) mkIf;
  inherit (self.lib) mkServiceOption;

  cfg = config.pixel.services.radarr;
in

{
  options.pixel.services.radarr = mkServiceOption "radarr" {
    port = 3021;
    domain = "movies.${config.networking.domain}";
  };

  config = mkIf cfg.enable {
    services = {
      radarr = {
        inherit (cfg) enable;
        group = "media";
        inherit (config.pixel.services.arr) openFirewall;
        settings.server.port = cfg.port;
      };

      nginx.virtualHosts.${cfg.domain}.locations."/".proxyPass = "http://127.0.0.1:${toString cfg.port}";
    };
  };
}
