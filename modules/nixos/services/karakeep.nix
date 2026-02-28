{
  lib,
  self,
  config,
  ...
}:

let
  inherit (lib.modules) mkIf;
  inherit (self.lib) mkServiceOption;

  rdomain = config.networking.domain;

  cfg = config.pixel.services.karakeep;
in

{
  options.pixel.services.karakeep = mkServiceOption "karakeep" {
    port = 3014;
    domain = "bookmarks.${rdomain}";
  };

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
