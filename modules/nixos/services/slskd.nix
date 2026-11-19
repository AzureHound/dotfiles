{
  lib,
  self,
  name,
  config,
  ...
}:

let
  inherit (lib.modules) mkIf;
  inherit (self.lib) mkService mkSecret;

  cfg = config.pixel.services.slskd;
in

{
  imports = [
    (mkService "slskd" {
      port = 5030;
      domain = "slskd.${config.networking.domain}";
      mediaDir = "/media/slskd";
    })
  ];

  config = mkIf cfg.enable {
    sops.secrets."slskd" = mkSecret {
      file = "slskd";
      key = "env";
      owner = "slskd";
    };

    users.users.slskd.extraGroups = [ config.users.users.${name}.group ];

    systemd.tmpfiles.settings."slskd" = {
      "${cfg.mediaDir}".d = {
        mode = "2775";
        user = name;
        group = config.users.users.${name}.group;
      };
      "${cfg.mediaDir}/incomplete".d = {
        mode = "2775";
        user = name;
        group = config.users.users.${name}.group;
      };
    };

    services = {
      slskd = {
        enable = true;
        environmentFile = config.sops.secrets."slskd".path;
        openFirewall = true;

        settings = {
          directories = {
            downloads = cfg.mediaDir;
            incomplete = "${cfg.mediaDir}/incomplete";
          };

          shares = {
            directories = [
              "/media/music"
            ];
          };

          web = {
            inherit (cfg) port;
          };
        };
      };

      nginx.virtualHosts.${cfg.domain}.locations."/" = {
        proxyPass = "http://127.0.0.1:${toString cfg.port}";
        proxyWebsockets = true;
      };
    };
  };
}
