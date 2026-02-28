{
  lib,
  self,
  name,
  config,
  ...
}:

let
  inherit (lib.modules) mkIf mkForce;
  inherit (self.lib) mkServiceOption mkSecret;

  rdomain = config.networking.domain;

  cfg = config.pixel.services.navidrome;
in

{
  options.pixel.services.navidrome = mkServiceOption "navidrome" {
    port = 4533;
    domain = "sounds.${rdomain}";
  };

  config = mkIf cfg.enable {
    sops.secrets.navidrome-env = mkSecret {
      file = "navidrome";
      key = "env";
    };

    services = {
      navidrome = {
        enable = true;

        user = name;
        group = "users";
        environmentFile = config.sops.secrets.navidrome-env.path;

        settings = {
          Port = cfg.port;
          MusicFolder = "/home/${name}/Music";
          DefaultTheme = "Catppuccin Macchiato";
        };
      };

      nginx.virtualHosts.${cfg.domain}.locations."/".proxyPass = "http://127.0.0.1:${toString cfg.port}";
    };

    systemd.services.navidrome.serviceConfig = {
      ProtectHome = mkForce "read-only";
    };
  };
}
