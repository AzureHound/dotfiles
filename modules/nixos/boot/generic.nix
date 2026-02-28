{ lib, config, ... }:

let
  inherit (lib.modules)
    mkIf
    mkMerge
    mkDefault
    mkForce
    ;
  inherit (lib.options) mkEnableOption;

  cfg = config.pixel.system.boot;
in

{
  options.pixel.system.boot = {
    initrd = {
      tweaks.enable = mkEnableOption "initrd tweaks" // {
        default = true;
      };

      optimizeCompressor =
        mkEnableOption ''
          Forces zstd compression at level 19 (-T0)
          to minimize initrd size at the cost of compression speed.
        ''
        // {
          default = config.pixel.profiles.workstation.enable;
        };
    };
  };

  config.boot = {
    consoleLogLevel = 0;

    extraModprobeConfig = mkDefault "options hid_apple fnmode=1";

    loader = {
      timeout = mkForce 2;
      generationsDir.copyKernels = true;
      efi.canTouchEfiVariables = true;
    };

    initrd = mkMerge [
      (mkIf cfg.initrd.tweaks.enable {
        verbose = false;

        kernelModules = [
          "nvme"
          "xhci_pci"
          "ahci"
          "btrfs"
          "sd_mod"
          "dm_mod"
        ];

        availableKernelModules = [
          "vmd"
          "usbhid"
          "sd_mod"
          # "sr_mod"
          "dm_mod"
          "uas"
          "usb_storage"
          "rtsx_usb_sdmmc"
          "rtsx_pci_sdmmc" # Realtek SD card interface
          # "ata_piix"
          "virtio_pci"
          "virtio_scsi"
          "ehci_pci"
        ];
      })

      (mkIf cfg.initrd.optimizeCompressor {
        compressor = "zstd";
        compressorArgs = [
          "-19"
          "-T0"
        ];
      })
    ];
  };
}
