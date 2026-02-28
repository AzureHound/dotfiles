{
  lib,
  config,
  inputs,
  ...
}:

let
  inherit (lib.modules) mkIf;
  inherit (config.pixel) device;
in

{
  imports = [ inputs.autoaspm.nixosModules.default ];

  powerManagement = {
    enable = true;
    powertop.enable = true;
    cpuFreqGovernor = mkIf (device.cpu == "amd" || device.cpu == "vm-amd") "powersave";
  };

  services.autoaspm.enable = true;
}
