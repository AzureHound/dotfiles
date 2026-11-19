{
  lib,
  self,
  config,
  ...
}:

let
  inherit (lib.modules) mkIf;
  inherit (self.lib) mkService;

  cfg = config.pixel.services.filebrowser;
in

{
  imports = [
    (mkService "filebrowser" {
      port = 9000;
      domain = "files.${config.networking.domain}";
    })
  ];

  config = mkIf cfg.enable {
    services = {
      filebrowser = {
        enable = true;
        openFirewall = true;
        # ```sh journalctl -u filebrowser.service --no-pager | grep "randomly generated password" ```

        settings = {
          address = "0.0.0.0";
          port = cfg.port;
        };
      };

      nginx.virtualHosts.${cfg.domain} = {
        default = true;
        forceSSL = false;
        enableACME = false;

        locations."/" = {
          proxyPass = "http://127.0.0.1:${toString cfg.port}";
          extraConfig = ''
            client_max_body_size 0;
          '';
        };
      };
    };

    networking.firewall.allowedTCPPorts = [ cfg.port ];
  };
}
