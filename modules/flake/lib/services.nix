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
    }@args:

    let
      host' = if args ? port then host else null;
    in

    {
      enable = mkEnableOption "Enable the ${name} service";

      ${if host' != null then "host" else null} = mkOption {
        type = str;
        default = host';
        description = "The host for ${name} service";
      };

      ${if args ? port then "port" else null} = mkOption {
        type = lib.types.port;
        default = args.port;
        description = "The port for ${name} service";
      };

      ${if args ? domain then "domain" else null} = mkOption {
        type = str;
        default = args.domain or null;
        defaultText = "networking.domain";
        description = "Domain name for the ${name} service";
      };
    };
in

{
  inherit mkServiceOption;
}
