{ lib, config, ... }:

let
  inherit (lib.modules) mkIf;
  inherit (lib.options) mkEnableOption;

  cfg = config.pixel.system.virtualization.windows;
in

{
  options.pixel.system.virtualization.windows.enable = mkEnableOption "windows";

  config = mkIf cfg.enable { pixel.services.docker.enable = true; };
}
