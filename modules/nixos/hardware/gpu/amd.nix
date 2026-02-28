{
  lib,
  pkgs,
  config,
  ...
}:

let
  inherit (lib.modules) mkIf;

  inherit (config.pixel) device;
in

{
  config = mkIf (device.gpu == "amd") {
    services.xserver.videoDrivers = [ "amdgpu" ];

    boot.kernelModules = [ "amdgpu" ];

    # AMDVLK & OpenCL support
    hardware.graphics.extraPackages = with pkgs; [
      rocmPackages.clr
      rocmPackages.clr.icd
    ];
  };
}
