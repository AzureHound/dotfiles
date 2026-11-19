{
  lib,
  self,
  config,
  ...
}:

let
  inherit (lib.modules) mkIf;
  inherit (self.lib) mkService;

  cfg = config.pixel.services.jellyfin;
in

{
  imports = [
    (mkService "jellyfin" {
      port = 8096;
      host = null;
      domain = "tv.${config.networking.domain}";
    })
  ];

  config = mkIf cfg.enable {
    users.users.jellyfin.extraGroups = [
      "render"
      "video"
    ];

    services = {
      jellyfin = {
        enable = true;
        group = "media";

        hardwareAcceleration = {
          enable = true;
          type = "nvenc";
          device = "/dev/dri/renderD128";
        };

        transcoding = {
          hardwareDecodingCodecs = {
            h264 = true;
            hevc = true;
            hevc10bit = true;
            hevcRExt10bit = true;
            hevcRExt12bit = true;
            mpeg2 = true;
            vc1 = true;
            vp8 = true;
            vp9 = true;
          };

          hardwareEncodingCodecs.hevc = true;
        };
      };

      nginx.virtualHosts.${cfg.domain}.locations."/".proxyPass = "http://127.0.0.1:${toString cfg.port}";
    };

    networking.firewall = {
      allowedTCPPorts = [
        cfg.port
      ];
      allowedUDPPorts = [
        1900
        7359
      ];
    };
  };
}
