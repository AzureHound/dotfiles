# https://discourse.nixos.org/t/can-we-solve-the-nvidia-situation/73198

{
  lib,
  pkgs,
  config,
  ...
}:

let
  inherit (lib.modules) mkIf mkDefault mkMerge;

  inherit (config.pixel) device;
in

{
  config = mkIf (device.gpu == "nvidia") (mkMerge [
    {
      services.xserver.videoDrivers = [ "nvidia" ];

      boot = {
        kernelParams = [ "nvidia_drm.fbdev=1" ];

        blacklistedKernelModules = [ "snd_hda_codec_hdmi" ];
      };

      environment = {
        sessionVariables = {
          GBM_BACKEND = "nvidia-drm";
          GDK_GL = "gles";
          LIBVA_DRIVER_NAME = "nvidia";
          NVD_BACKEND = "direct"; # Hardware video decode
          WLR_DRM_DEVICES = mkDefault "/dev/dri/card1";
          __GLX_VENDOR_LIBRARY_NAME = "nvidia";
        };

        systemPackages = with pkgs; [
          nvitop

          # vulkan
          vulkan-tools
          vulkan-loader
          vulkan-validation-layers
          vulkan-extension-layer

          # libva
          libva
          libva-utils
        ];
      };

      hardware = {
        nvidia = {
          branch = "bleeding_edge";

          powerManagement = {
            enable = true;
            finegrained = false;
          };

          open = false;
          nvidiaSettings = false;
          modesetting.enable = true;
        };

        graphics = {
          extraPackages = with pkgs; [ nvidia-vaapi-driver ];
          # extraPackages32 = [ pkgs.pkgsi686Linux.nvidia-vaapi-driver ];
        };
      };
    }

    (mkIf config.pixel.profiles.gaming.enable {
      programs.steam.gamescopeSession.env = {
        WLR_NO_HARDWARE_CURSORS = "1";
      };

      environment.sessionVariables = {
        __GL_GSYNC_ALLOWED = "1";
        __GL_VRR_ALLOWED = "1";
      };
    })
  ]);
}
