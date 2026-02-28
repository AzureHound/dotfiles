{
  lib,
  self,
  name,
  config,
  ...
}:

let
  inherit (lib.modules) mkIf;
  inherit (lib.options) mkOption mkEnableOption;
  inherit (lib) types;
  inherit (self.lib) mkSecret;

  cfg = config.pixel.services.slskd;
in

{
  options.pixel.services.slskd = {
    enable = mkEnableOption "slskd";

    port = mkOption {
      type = types.port;
      default = 5030;
    };

    domain = mkOption {
      type = types.str;
      default = "slskd.${config.networking.domain}";
    };

    mediaDir = mkOption {
      type = types.str;
      default = "/media/slskd";
    };
  };

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
