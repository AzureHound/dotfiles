{
  lib,
  self,
  name,
  config,
  ...
}:

let
  inherit (lib.modules) mkIf;
  inherit (self.lib) mkService;
in

{
  imports = [ (mkService "samba" { }) ];

  config = mkIf config.pixel.services.samba.enable {
    systemd.tmpfiles.settings."samba" = {
      "/media/smb".d = {
        mode = "0755";
        user = name;
        group = "users";
      };
    };

    services.samba = {
      enable = true;
      openFirewall = true;

      settings = {
        global = {
          "workgroup" = "WORKGROUP";
          "server string" = "smb svr";
          "security" = "user";
        };

        storage = {
          "path" = "/media/smb";
          "browsable" = "yes";
          "read only" = "no";
          "guest ok" = "no";
          "create mask" = "0644";
          "directory mask" = "0755";
          "valid users" = name;
        };
      };
    };
  };
}
