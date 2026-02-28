{
  lib,
  pkgs,
  config,
  ...
}:

let
  inherit (lib.modules) mkOverride;
  inherit (lib.options) mkOption;
  inherit (lib.types) raw;

  cfg = config.pixel.system.kernel;
in

{
  options.pixel.system.kernel = {
    packages = mkOption {
      type = raw;
      default = pkgs.linuxPackages_zen;
    };
  };

  config = {
    boot.kernelPackages = mkOverride 500 cfg.packages;
  };
}
