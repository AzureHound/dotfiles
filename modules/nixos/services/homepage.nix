{
  lib,
  self,
  name,
  config,
  ...
}:

let
  inherit (lib.modules) mkIf;
  inherit (self.lib) mkServiceOption;

  rdomain = config.networking.domain;

  cfg = config.pixel.services.homepage;
in

{
  options.pixel.services.homepage = mkServiceOption "homepage" {
    domain = rdomain;
  };

  config = mkIf cfg.enable {
    pixel.services = {
      nginx.enable = true;
    };

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
