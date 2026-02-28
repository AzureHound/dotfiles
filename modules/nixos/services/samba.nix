{
  lib,
  self,
  name,
  config,
  ...
}:

let
  inherit (lib.modules) mkIf;
  inherit (self.lib) mkServiceOption;
in

{
  options.pixel.services.samba = mkServiceOption "samba" { };

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
          "browseable" = "yes";
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
