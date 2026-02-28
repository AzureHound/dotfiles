{
  lib,
  self,
  config,
  ...
}:

let
  inherit (lib.modules) mkIf mkForce;
  inherit (self.lib) mkServiceOption mkSecret;

  rdomain = config.networking.domain;

  cfg = config.pixel.services.opencloud;
in

{
  options.pixel.services.opencloud = mkServiceOption "opencloud" {
    port = 9200;
    domain = "cloud.${rdomain}";
  };

  config = mkIf cfg.enable {
    sops.secrets.opencloud-env = mkSecret {
      file = "opencloud";
      key = "env";
    };

    services = {
      opencloud = {
        enable = true;

        url = "https://${cfg.domain}";
        inherit (cfg) port;

        environmentFile = config.sops.secrets.opencloud-env.path;

        environment = {
          PROXY_TLS = "false";
        };

        settings = {
          proxy = {
            additional_policies = [
              {
                name = "default";
                routes = [
                  {
                    endpoint = "/caldav/";
                    backend = "http://127.0.0.1:5232";
                    remote_user_header = "X-Remote-User";
                    skip_x_access_token = true;
                    additional_headers = [ { "X-Script-Name" = "/caldav"; } ];
                  }
                  {
                    endpoint = "/.well-known/caldav";
                    backend = "http://127.0.0.1:5232";
                    remote_user_header = "X-Remote-User";
                    skip_x_access_token = true;
                    additional_headers = [ { "X-Script-Name" = "/caldav"; } ];
                  }
                  {
                    endpoint = "/carddav/";
                    backend = "http://127.0.0.1:5232";
                    remote_user_header = "X-Remote-User";
                    skip_x_access_token = true;
                    additional_headers = [ { "X-Script-Name" = "/carddav"; } ];
                  }
                  {
                    endpoint = "/.well-known/carddav";
                    backend = "http://127.0.0.1:5232";
                    remote_user_header = "X-Remote-User";
                    skip_x_access_token = true;
                    additional_headers = [ { "X-Script-Name" = "/carddav"; } ];
                  }
                ];
              }
            ];
          };
        };
      };

      nginx.virtualHosts.${cfg.domain}.locations."/" = {
        proxyPass = "http://127.0.0.1:${toString cfg.port}";
        proxyWebsockets = true;
        extraConfig = ''
          client_max_body_size 512M;
        '';
      };
    };

    systemd.services.opencloud-init-config.script = mkForce ''
      set -x
      config="''${OC_CONFIG_DIR}/opencloud.yaml"
      if [ ! -e "$config" ]; then
        echo "Provisioning initial OpenCloud config..."
        opencloud init --insecure "''${OC_INSECURE:-false}" --config-path "''${OC_CONFIG_DIR}"
        chown ${config.services.opencloud.user}:${config.services.opencloud.group} "$config"
      fi
    '';
  };
}
