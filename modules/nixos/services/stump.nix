{
  lib,
  self,
  name,
  config,
  ...
}:

let
  inherit (lib.modules) mkIf;
  inherit (self.lib) mkService;

  rdomain = config.networking.domain;

  cfg = config.pixel.services.stump;
in

{
  imports = [
    (mkService "stump" {
      port = 10001;
      domain = "comics.${rdomain}";
      mediaDir = "/media/comics";
    })
  ];

  config = mkIf cfg.enable {
    users.users.stump.extraGroups = [ config.users.users.${name}.group ];

    systemd.tmpfiles.settings."stump" = {
      "${cfg.mediaDir}".d = {
        mode = "2775";
        user = name;
        group = config.users.users.${name}.group;
      };
    };

    services = {
      stump = {
        enable = true;
        inherit (cfg) port;
        environment = {
          STUMP_ENABLE_UPLOAD = "true";
        };
      };

      nginx.virtualHosts.${cfg.domain}.locations."/" = {
        proxyPass = "http://127.0.0.1:${toString cfg.port}";
        proxyWebsockets = true;
        extraConfig = ''
          client_max_body_size 0;
        '';
      };
    };

    systemd.services.stump.serviceConfig = {
      ReadWritePaths = [ cfg.mediaDir ];
    };
  };
}
