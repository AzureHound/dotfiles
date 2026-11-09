{ lib, config, ... }:

let
  inherit (lib.attrsets) optionalAttrs;
  inherit (lib.options) mkOption;
  inherit (lib.types)
    attrsOf
    nullOr
    str
    submodule
    ;

  inherit (config.pixel.fleet.${config.networking.hostName}) wakeOnLan;

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
        };
      });
      default = { };
      description = "Facts about every host, identical on all of them, so no host has to evaluate another to learn about it";
    };

  };

  config = {
    pixel.fleet = {
      Legion = {
        ipv4 = "10.10.0.4";
        # ipv6 = "2a01:4f8:c012:2f67::1";
      };

      Newton = {
        # wakeOnLan = "enp4s0";
      };

      Notebook = { };

      Orion = { };
    };

    networking.interfaces = optionalAttrs (wakeOnLan != null) {
      ${wakeOnLan}.wakeOnLan.enable = true;
    };
  };
}
