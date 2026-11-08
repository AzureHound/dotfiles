{ lib, config, ... }:

let
  inherit (config.pixel.services) immich jellyfin;

  relay = port: cached: {
    extraConfig = ''
      client_max_body_size 0;
      proxy_buffering off;
      proxy_request_buffering off;
      proxy_read_timeout 600s;
      proxy_send_timeout 600s;
    '';

    locations =
      let
        upstream = "http://legion:${toString port}";
      in
      {
        "/" = {
          proxyPass = upstream;
          proxyWebsockets = true;
        };
      }
      // lib.attrsets.genAttrs cached (_: {
        proxyPass = upstream;
        extraConfig = ''
          proxy_buffering on;
          proxy_cache static;
        '';
      });
  };
in

{
  services.nginx.virtualHosts = {
    "photos.softshell.duckdns.org" = relay immich.port [ ];
    "tv.softshell.duckdns.org" = relay jellyfin.port [ "~ ^/Items/.+/Images/" ];
  };

  systemd.services.nginx = {
    after = [ "tailscaled.service" ];
    wants = [ "tailscaled.service" ];
  };
}
