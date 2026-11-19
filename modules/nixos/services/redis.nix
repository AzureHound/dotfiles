{
  lib,
  self,
  pkgs,
  config,
  ...
}:

let
  inherit (lib.modules) mkIf mkMerge;
  inherit (self.lib) mkService;

  cfg = config.pixel.services;
in

{
  imports = [
    (mkService "redis" { port = 6371; })
  ];

  config = mkIf cfg.redis.enable {
    services.redis = {
      package = pkgs.valkey;

      servers = mkMerge [
        (mkIf cfg.forgejo.enable {
          forgejo = {
            enable = true;
            user = "forgejo";
            inherit (cfg.redis) port;
            bind = cfg.redis.host;
            databases = 16;
            logLevel = "debug";
            requirePass = "forgejo";
          };
        })
      ];
    };
  };
}
