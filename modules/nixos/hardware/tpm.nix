{ lib, config, ... }:

let
  inherit (lib.modules) mkIf;
  inherit (lib.options) mkOption;
  inherit (lib.types) bool;

  inherit (config.pixel) device;
in

{
  options.pixel.device.capabilities.tpm = mkOption {
    type = bool;
    default = false;
  };

  config = mkIf device.capabilities.tpm {
    security.tpm2 = {
      enable = true;

      # - TPM2TOOLS_TCTI
      # - TPM2_PKCS11_TCTI
      tctiEnvironment.enable = true;

      pkcs11.enable = true;
    };

    boot.initrd.kernelModules = [ "tpm" ];
  };
}
