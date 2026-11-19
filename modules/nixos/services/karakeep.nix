{
  lib,
  self,
  config,
  ...
}:

let
  inherit (lib.modules) mkIf;
  inherit (self.lib) mkService;

  rdomain = config.networking.domain;

  cfg = config.pixel.services.karakeep;
in

{
  imports = [
    (mkService "karakeep" {
      port = 3014;
      domain = "bookmarks.${rdomain}";
    })
  ];

  config = mkIf cfg.enable {
    services = {
      karakeep = {
        enable = true;

        extraEnvironment = {
          PORT = toString cfg.port;
        };
      };

      nginx.virtualHosts.${cfg.domain}.locations."/".proxyPass = "http://127.0.0.1:${toString cfg.port}";
    };
  };
}
