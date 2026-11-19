{
  lib,
  self,
  config,
  ...
}:

let
  inherit (lib.modules) mkIf;
  inherit (self.lib) mkService;

  inherit (config.pixel.services) arr;

  cfg = config.pixel.services.qbittorrent;
in

{
  imports = [
    (mkService "qbittorrent" {
      port = 3019;
      host = "0.0.0.0";
      webuiPort = 4019;
      torrentingPort = 43125;
    })
  ];

  config = mkIf cfg.enable {
    services = {
      qbittorrent = {
        enable = true;
        group = arr.mediaGroup;

        inherit (cfg) webuiPort torrentingPort;

        serverConfig = {
          LegalNotice.Accepted = true;

          BitTorrent.Session = {
            BTProtocol = "TCP";
            DHTEnabled = true;
            LSDEnabled = false;
            PeXEnabled = true;
            QueueingSystemEnabled = false;

            DefaultSavePath = "${arr.mediaDir}/downloads";
            DisableAutoTMMByDefault = false;
            DisableAutoTMMTriggers = {
              CategorySavePathChanged = false;
              DefaultSavePathChanged = false;
            };
          };

          Core.AutoDeleteAddedTorrentFile = "IfAdded";

          Preferences.WebUI = {
            LocalHostAuth = false;

            # https://codeberg.org/feathecutie/qbittorrent_password
            Password_PBKDF2 = "@ByteArray(2PRai2N/GL+Lt+VDdda0kw==:X4+iM6WwTPXExbBwJGcrHqxVsEN0cBxrhACiTMbEeQ6RjTdbfnJSB+CyTn3r1iJzEMMa0/XZzq2U1cG4O6AZZg==)";
          };
        };
      };

      nginx.virtualHosts.${cfg.domain}.locations."/" = {
        proxyPass = "http://127.0.0.1:${toString config.services.qbittorrent.webuiPort}";
        extraConfig = ''
          proxy_set_header Accept-Encoding "";
          proxy_hide_header Content-Security-Policy;

          sub_filter '</head>' '<link rel="stylesheet" type="text/css" href="https://theme-park.dev/css/base/qbittorrent/catppuccin-macchiato.css"></head>';
          sub_filter_once on;
        '';
      };
    };

    networking.firewall.allowedTCPPorts = [
      config.services.qbittorrent.torrentingPort
      cfg.port
    ];
  };
}
