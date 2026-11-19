{
  lib,
  pkgs,
  self,
  config,
  ...
}:

let
  inherit (lib.modules) mkIf;
  inherit (self.lib) mkService;

  cfg = config.pixel.services.docker;
in

{
  imports = [ (mkService "docker" { }) ];

  config = mkIf cfg.enable {
    virtualisation.docker = {
      enable = true;
      autoPrune.enable = true;
    };

    environment.systemPackages = with pkgs; [
      # docker-buildx
      docker-compose
    ];
  };
}
