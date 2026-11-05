{ lib, config, ... }:

let
  inherit (lib.modules) mkIf mkMerge;
  inherit (lib.strings) concatStringsSep;

  cfg = config.pixel.services;

  web = {
    port = "http,https";
    protocol = "tcp,udp";
  };

  accessLog = web // {
    backend = "auto";
    logpath = "/var/log/nginx/access.log";
  };

  journalJail = unit: regexes: settings: {
    filter.Definition = {
      failregex = concatStringsSep "\n    " regexes;
      ignoreregex = "";
    };
    settings = web // { journalmatch = "_SYSTEMD_UNIT=${unit}.service"; } // settings;
  };

  vaultwardenJail =
    failregex:
    journalJail "vaultwarden" [ failregex ] {
      maxretry = 3;
      bantime = 14400;
      findtime = 14400;
    };
in

{
  services.fail2ban = {
    enable = true;
    maxretry = 7;
    ignoreIP = [
      "127.0.0.0/8"
      "10.10.0.0/8"
      "192.168.0.0/16"
      "100.118.0.0/10"
    ];

    bantime-increment = {
      enable = true;
      rndtime = "12m";
      overalljails = true;
      multipliers = "4 8 16 32 64 128 256 512 1024 2048";
      maxtime = "192h";
    };

    jails = mkMerge [
      {
        sshd.settings.mode = "aggressive";
      }

      (mkIf config.services.nginx.enable {
        nginx-limit-req.settings = web;
        nginx-botsearch.settings = accessLog;
      })

      # https://github.com/dani-garcia/vaultwarden/wiki/Fail2Ban-Setup
      (mkIf cfg.vaultwarden.enable {
        vaultwarden = vaultwardenJail ''^.*?Username or password is incorrect\. Try again\. IP: <ADDR>\. Username:.*$'';
        vaultwarden-admin = vaultwardenJail ''^.*?Invalid admin token\. IP: <ADDR>.*$'';
      })

      (mkIf cfg.forgejo.enable {
        forgejo = journalJail "forgejo" [
          ''^.*Failed authentication attempt for .* from <ADDR>(?::\d+)?:''
          ''^.*router: completed \S+ \S+ for <ADDR>:\d+, 401 Unauthorized''
        ] { maxretry = 10; };
      })
    ];
  };
}
