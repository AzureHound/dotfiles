{ lib, ... }:

let
  inherit (lib.types) str;
  inherit (lib.options) mkOption mkEnableOption;

  mkServiceOption =
    name:
    {
      port ? null,
      host ? "127.0.0.1",
      domain ? null,
    }:

    let
      host' = if port == null then null else host;
    in

    {
      enable = mkEnableOption "Enable the ${name} service";

      ${if host' != null then "host" else null} = mkOption {
        type = str;
        default = host';
        description = "The host for ${name} service";
      };

      ${if port != null then "port" else null} = mkOption {
        type = lib.types.port;
        default = port;
        description = "The port for ${name} service";
      };

      ${if domain != null then "domain" else null} = mkOption {
        type = str;
        default = domain;
        defaultText = "networking.domain";
        description = "Domain name for the ${name} service";
      };
    };
in

{
  inherit mkServiceOption;
}
