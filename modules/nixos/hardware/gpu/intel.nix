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
  config = mkIf (device.gpu == "intel" || device.gpu == "hybrid-nv") {
    services.xserver.videoDrivers = [ "modesetting" ];

    hardware.graphics = {
      extraPackages = with pkgs; [
        # intel-gpu-tools
        intel-media-driver
        # intel-vaapi-driver
        # libva-vdpau-driver
        # intel-compute-runtime # OpenCL filter support [ hardware tonemapping & subtitle burn-in ]
        vpl-gpu-rt # QSV on 11th gen or newer
      ];

      # extraPackages32 = [ pkgs.pkgsi686Linux.intel-media-driver ];
    };

    environment = {
      # variables = mkIf (config.hardware.graphics.enable && device.gpu != "hybrid-nv") {
      #   LIBVA_DRIVER_NAME = "iHD";
      #   VDPAU_DRIVER = "va_gl";
      # };

      systemPackages = with pkgs; [ nvtopPackages.intel ];
    };
  };
}
