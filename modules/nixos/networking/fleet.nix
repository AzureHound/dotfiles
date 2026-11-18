{
  lib,
  self,
  config,
  ...
}:

let
  inherit (lib.modules) mkIf;
  inherit (lib.options) mkOption;
  inherit (lib.types)
    anything
    attrsOf
    listOf
    nullOr
    str
    submodule
    ;

  fleet = config.pixel.fleet.${config.networking.hostName} or { };
  wakeOnLan = fleet.wakeOnLan or null;

  address =
    description: example:
    mkOption {
      type = nullOr str;
      default = null;
      inherit description example;
    };
in

{
  options.pixel = {
    fleet = mkOption {
      type = attrsOf (submodule {
        options = {
          ipv4 = address "The IPv4 address on the host's primary interface" "203.0.113.10";
          ipv6 = address "The IPv6 address on the host's primary interface" "2001:db8::1";
          wakeOnLan = address "The interface on which to enable Wake-on-LAN" "enp1s0";

          services = mkOption {
            type = attrsOf (attrsOf anything);
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
      fleet = lib.trivial.importTOML "${self}/hosts/fleet.toml";

      services = fleet.services or { };
    };

    networking = mkIf (wakeOnLan != null) {
      interfaces.${wakeOnLan}.wakeOnLan.enable = true;
      firewall.allowedUDPPorts = [ 9 ];
    };
  };
}
