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
    domain = "indexers.${config.networking.domain}";
  };

  config = mkIf cfg.enable {
    services = {
      prowlarr = {
        enable = true;
        inherit (config.pixel.services.arr) openFirewall;
        settings.server.port = cfg.port;
      };

      nginx.virtualHosts.${cfg.domain}.locations."/".proxyPass = "http://127.0.0.1:${toString cfg.port}";
    };
  };
}
