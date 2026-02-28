{
  lib,
  self,
  config,
  ...
}:

let
  inherit (lib.modules) mkIf;
  inherit (self.lib) mkServiceOption;

  rdomain = config.networking.domain;

  cfg = config.pixel.services.technitium;
in

{
  options.pixel.services.technitium = mkServiceOption "technitium" {
    port = 5380;
    domain = "dns.${rdomain}";
  };

  config = mkIf cfg.enable {
    networking.firewall = {
      allowedTCPPorts = [ 53 ];
      allowedUDPPorts = [ 53 ];
    };

    services = {
      technitium-dns-server = {
        enable = true;
      };

      nginx.virtualHosts.${cfg.domain}.locations."/".proxyPass = "http://localhost:${toString cfg.port}";
    };

    systemd.services.technitium-dns-server.serviceConfig = {
      LogsDirectory = "technitium";
    };
  };
}
