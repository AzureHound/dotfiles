{ lib, ... }:

let
  inherit (lib.options) mkOption mkEnableOption;
  inherit (lib.types) str;

  mkServiceOption =
    name:
    {
      port ? 0,
      host ? "127.0.0.1",
      domain ? "",
    }:
    {
      enable = mkEnableOption "Init ${name} service";

      host = mkOption {
        type = str;
        default = host;
      };

      port = mkOption {
        type = lib.types.port;
        default = port;
      };

      domain = mkOption {
        type = str;
        default = domain;
      };
    };
in

{
  inherit mkServiceOption;
}
