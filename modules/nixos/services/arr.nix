{
  lib,
  self,
  config,
  ...
}:

let
  inherit (lib.attrsets) genAttrs;
  inherit (lib.modules) mkIf;
  inherit (self.lib) mkService;

  cfg = config.pixel.services.arr;
in

{
  imports = [
    (mkService "arr" {
      mediaDir = "/media";
      contentDir = "/media/content";
      mediaOwner = "root";
      mediaGroup = "media";
    })
    {
      pixel.services = {
        jellyfin.enable = mkIf cfg.enable true;
        # prowlarr.enable = mkIf cfg.enable true;
        qbittorrent.enable = mkIf cfg.enable true;
        # radarr.enable = mkIf cfg.enable false;
        # sonarr.enable = mkIf cfg.enable true;
      };
    }
  ];

  config = mkIf cfg.enable {
    users.groups.media = { };

    systemd.tmpfiles.settings."media" =
      genAttrs
        [
          "${cfg.mediaDir}"
          "${cfg.mediaDir}/content"
          "${cfg.mediaDir}/content/home"
          "${cfg.mediaDir}/content/movies"
          "${cfg.mediaDir}/content/shows"

          "${cfg.mediaDir}/downloads"
          "${cfg.mediaDir}/downloads/movies"
          "${cfg.mediaDir}/downloads/shows"
        ]
        (_: {
          d = {
            mode = "0775";
            user = cfg.mediaOwner;
            group = cfg.mediaGroup;
          };
        });
  };
}
