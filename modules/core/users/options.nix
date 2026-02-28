{
  lib,
  name,
  config,
  ...
}:

let
  inherit (lib.lists) optional;
  inherit (lib.options) mkOption;
  inherit (lib.types) str listOf enum;
in

{
  options.pixel.system = {
    mainUser = mkOption {
      type = enum config.pixel.system.users;
      default = builtins.elemAt config.pixel.system.users 0;
    };

    users = mkOption {
      type = listOf str;
      default = [ name ];
    };
  };

  config = {
    warnings = optional (config.pixel.system.users == [ ]) ''
      No users added. System may end up unbootable!

      Consider setting {option}config.pixel.system.users in config.
    '';
  };
}
