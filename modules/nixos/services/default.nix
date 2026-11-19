{ lib, ... }:

let
  inherit (lib.modules) mkOverride;
  inherit (lib.options) mkEnableOption mkOption;
  inherit (lib.types)
    anything
    attrsOf
    nullOr
    port
    str
    submodule
    ;

  fallback = mkOverride 1600;
in

{
  options.pixel.services = mkOption {
    type = attrsOf (
      submodule (
        { name, config, ... }:
        {
          freeformType = attrsOf anything;

          options = {
            enable = mkEnableOption "the ${name} service";

            host = mkOption {
              type = nullOr str;
            };

            port = mkOption {
              type = nullOr port;
            };

            domain = mkOption {
              type = nullOr str;
            };
          };

          config = {
            host = fallback (if config.port == null then null else "127.0.0.1");
            port = fallback null;
            domain = fallback null;
          };
        }
      )
    );
    default = { };
  };

  imports = [
    ./arr.nix
    ./atuin.nix
    ./filebrowser.nix
    ./forgejo.nix
    ./home-assistant
    ./homepage.nix
    ./immich.nix
    ./jellyfin.nix
    ./karakeep.nix
    ./lego.nix
    ./microbin.nix
    ./navidrome.nix
    # ./nixbot.nix
    ./nginx.nix
    ./ollama.nix
    ./open-webui.nix
    ./opencloud.nix
    ./postgresql.nix
    ./prowlarr.nix
    ./qbittorrent.nix
    ./radarr.nix
    ./radicale.nix
    ./redis.nix
    # ./rsync.nix # TODO:
    ./samba.nix
    ./searx.nix
    ./slskd.nix
    ./sonarr.nix
    ./stash.nix
    ./stump.nix
    ./syncthing.nix
    ./technitium.nix
    ./vaultwarden.nix
  ];
}
