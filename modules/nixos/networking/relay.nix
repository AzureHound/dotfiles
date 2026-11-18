{ lib, config, ... }:

let
  inherit (lib.attrsets)
    filterAttrs
    genAttrs'
    mapAttrsToList
    nameValuePair
    ;
  inherit (lib.lists) concatLists;
  inherit (lib.modules) mkIf;

  inherit (config.networking) hostName;

  relayed = filterAttrs (_: fleet: hostName == fleet.relay.via or null) config.pixel.fleet;

  served = concatLists (
    mapAttrsToList (
      host: fleet:
      map (
        name:
        let
          set = fleet.services.${name} or { };
          defaults = config.pixel.services.${name};
        in
        {
          inherit host name;
          enable = set.enable or false;
          port = set.port or defaults.port;
          domain = set.domain or defaults.domain;
        }
      ) fleet.relay.services
    ) relayed
  );

  vhost =
    service:
    nameValuePair service.domain {
      extraConfig = ''
        client_max_body_size 0;
        proxy_buffering off;
        proxy_request_buffering off;
        proxy_read_timeout 600s;
        proxy_send_timeout 600s;
      '';

      locations."/" = {
        proxyPass = "http://${service.host}:${toString service.port}";
        proxyWebsockets = true;
      };
    };
in

{
  config = mkIf (relayed != { }) {
    assertions = map (service: {
      assertion = service.enable;
      message = "${service.host} relays ${service.name} through ${hostName} but doesn't enable it in systems/fleet.toml";
    }) served;

    systemd.services.nginx = {
      after = [ "tailscaled.service" ];
      wants = [ "tailscaled.service" ];
    };

    services.nginx.virtualHosts = genAttrs' served vhost;
  };
}
