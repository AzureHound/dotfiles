{ config, ... }:

let
  inherit (config.pixel.services) immich jellyfin;

  relay = port: {
    extraConfig = ''
      client_max_body_size 0;
      proxy_buffering off;
      proxy_request_buffering off;
      proxy_read_timeout 600s;
      proxy_send_timeout 600s;
    '';

    locations."/" = {
      proxyPass = "http://${config.pixel.fleet.Legion.tailscale}:${toString port}";
      proxyWebsockets = true;
    };
  };
in

{
  services.nginx.virtualHosts = {
    "photos.softshell.duckdns.org" = relay immich.port;
    "tv.softshell.duckdns.org" = relay jellyfin.port;
  };
}
