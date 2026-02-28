{
  lib,
  self,
  config,
  ...
}:

let
  inherit (lib.modules) mkIf;
  inherit (self.lib.services) mkServiceOption;

  rdomain = config.networking.domain;

  cfg = config.pixel.services.microbin;
in

{
  options.pixel.services.microbin = mkServiceOption "microbin" {
    port = 8069;
    domain = "bin.${rdomain}";
  };

  config = mkIf cfg.enable {
    services = {
      microbin = {
        enable = true;

        settings = {
          MICROBIN_PORT = cfg.port;

          MICROBIN_DEFAULT_EXPIRY = "1week";
          MICROBIN_ENABLE_READONLY = true;
          MICROBIN_HASH_IDS = true;
          MICROBIN_HIDE_FOOTER = true;
          MICROBIN_QR = true;
          MICROBIN_WIDE = true;
        };
      };

      nginx.virtualHosts.${cfg.domain}.locations."/".proxyPass = "http://127.0.0.1:${toString cfg.port}";
    };
  };
}
