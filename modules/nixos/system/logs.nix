{ lib, config, ... }:

let
  inherit (lib.modules) mkIf;
in

{
  config = mkIf (!config.pixel.profiles.server.enable) {
    # https://wiki.archlinux.org/title/Systemd/Journal#Persistent_journals
    services.journald.extraConfig = ''
      SystemMaxUse=100M
      RuntimeMaxUse=50M
      SystemMaxFileSize=50M
    '';
  };
}
