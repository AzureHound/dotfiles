{ lib, config, ... }:

let
  inherit (lib.modules) mkIf;
  inherit (lib.options) mkOption mkEnableOption;
  inherit (lib.types) str int;

  cfg = config.pixel.system.security.auditd;
in

{
  options.pixel.system.security.auditd = {
    enable = mkEnableOption "Audit daemon";

    autoPrune = {
      enable = mkEnableOption "Auto-pruning of audit logs" // {
        default = cfg.enable;
      };

      size = mkOption {
        type = int;
        default = 524288000; # ~500 megabytes
      };

      dates = mkOption {
        type = str;
        default = "daily";
      };
    };
  };

  config = mkIf cfg.enable {
    security = {
      auditd.enable = true;

      audit = {
        enable = true;
        backlogLimit = 8192;
        failureMode = "printk";
        rules = [ "-a exit,always -F arch=b64 -S execve" ];
      };
    };

    systemd = mkIf cfg.autoPrune.enable {
      timers."clean-audit-log" = {
        wantedBy = [ "timers.target" ];
        timerConfig = {
          OnCalendar = cfg.autoPrune.dates;
          Persistent = true;
        };
      };

      services."clean-audit-log" = {
        script = ''
          set -eu
          if [[ $(stat -c "%s" /var/log/audit/audit.log) -gt ${toString cfg.autoPrune.size} ]]; then
            echo "Clearing Audit Log";
            rm -rvf /var/log/audit/audit.log;
            echo "Done!"
          fi
        '';

        serviceConfig = {
          Type = "oneshot";
          User = "root";
        };
      };
    };
  };
}
