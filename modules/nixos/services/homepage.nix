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

  cfg = config.pixel.services.homepage;
in

{
  imports = [
    (mkService "homepage" {
      domain = rdomain;
    })
    {
      pixel.services.nginx.enable = mkIf cfg.enable true;
    }
  ];

  config = mkIf cfg.enable {
    users.users.nginx.extraGroups = [ config.users.users.${name}.group ];

    services.nginx.virtualHosts.${cfg.domain} = {
      root = "/srv/homepage";
      locations."/".index = "index.html";
    };

    systemd.services.nginx.serviceConfig = {
      BindReadOnlyPaths = [
        "/home/${name}/Developer/Startpage:/srv/homepage"
      ];

      ProtectHome = "read-only";
    };
  };
}
