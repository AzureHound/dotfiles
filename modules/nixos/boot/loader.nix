{
  lib,
  pkgs,
  config,
  ...
}:

let
  inherit (lib.modules)
    mkIf
    mkMerge
    mkDefault
    mkForce
    ;
  inherit (lib.options) mkOption mkEnableOption mkPackageOption;
  inherit (lib.types) str enum nullOr;

  cfg = config.pixel.system.boot;
in

{
  options.pixel.system.boot = {
    loader = mkOption {
      type = enum [
        "none"
        "grub"
        "systemd-boot"
      ];
      default = "none";
    };

    grub = {
      device = mkOption {
        type = nullOr str;
        default = "nodev";
      };
    };

    memtest = {
      enable = mkEnableOption "memtest86+";
      package = mkPackageOption pkgs "memtest86plus" { };
    };
  };

  config = mkMerge [
    (mkIf (cfg.loader == "none") {
      boot.loader = {
        grub.enable = mkForce false;
        systemd-boot.enable = mkForce false;
      };
    })

    (mkIf (cfg.loader == "grub") {
      boot.loader.grub = {
        enable = mkDefault true;
        useOSProber = true;
        efiSupport = true;
        enableCryptodisk = mkDefault false;
        inherit (cfg.grub) device;
        theme = null;
        backgroundColor = null;
        splashImage = null;
      };
    })

    (mkIf (cfg.loader == "systemd-boot") {
      boot.loader.systemd-boot = {
        enable = mkDefault true;
        configurationLimit = 14;

        # https://systemd.io/AUTOMATIC_BOOT_ASSESSMENT
        bootCounting.enable = true;

        editor = false;
      };
    })

    (mkIf cfg.memtest.enable {
      boot.loader.systemd-boot = {
        extraFiles."efi/memtest86plus/memtest.efi" = "${cfg.boot.memtest.package}/memtest.efi";
        extraEntries."memtest86plus.conf" = ''
          title MemTest86+
          efi   /efi/memtest86plus/memtest.efi
        '';
      };
    })
  ];
}
