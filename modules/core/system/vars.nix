{
  lib,
  _class,
  name,
  config,
  ...
}:

let
  inherit (lib.options) mkOption;
  inherit (lib.types) str;
in

{
  options.pixel.environment.flakePath = mkOption {
    type = str;
    default = "${if (_class == "nixos") then "/home" else "/Users"}/${name}/Developer/dotfiles";
  };

  config.environment.variables = {
    SYSTEMD_PAGERSECURE = "true";

    FLAKE = config.pixel.environment.flakePath;
    NH_FLAKE = config.pixel.environment.flakePath;
  };
}
