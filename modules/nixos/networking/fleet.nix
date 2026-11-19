{
  lib,
  self,
  config,
  options,
  ...
}:

let
  inherit (lib.modules) mkIf;
  inherit (lib.options) mkOption;
  inherit (lib.types)
    attrsOf
    listOf
    nullOr
    str
    submodule
    ;

  data = lib.trivial.importTOML "${self}/hosts/fleet.toml";

  fleet = config.pixel.fleet.${config.networking.hostName} or { };
  wakeOnLan = fleet.wakeOnLan or null;

  address = mkOption {
    type = nullOr str;
    default = null;
  };
in

{
  options.pixel = {
    fleet = mkOption {
      type = attrsOf (submodule {
        options = {
          ipv4 = address;
          ipv6 = address;
          wakeOnLan = address;

          services = mkOption {
            inherit (options.pixel.services) type;
            default = { };
          };

          relay = mkOption {
            type = nullOr (submodule {
              options = {
                via = mkOption {
                  type = str;
                };

                services = mkOption {
                  type = listOf str;
                };
              };
            });
            default = null;
          };
        };
      });
      default = { };
    };
  };

  config = {
    pixel = {
      fleet = data;

      services = data.${config.networking.hostName}.services or { };
    };

    networking = mkIf (wakeOnLan != null) {
      interfaces.${wakeOnLan}.wakeOnLan.enable = true;
      firewall.allowedUDPPorts = [ 9 ];
    };
  };
}
