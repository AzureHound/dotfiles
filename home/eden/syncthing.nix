{
  name,
  config,
  osClass,
  ...
}:

let
  home = "${if osClass == "nixos" then "/home" else "/Users"}/${name}";
in

{
  sops.secrets."syncthing/passwd" = { };

  services.syncthing = {
    guiAddress = "127.0.0.1:8384";

    guiCredentials = {
      username = name;
      passwordFile = config.sops.secrets."syncthing/passwd".path;
    };

    settings = {
      devices = {
        "Notebook" = {
          id = "QWDKFNR-4EYOSYD-YNOJIB5-R4TTEL3-HEBDWBP-5FBH5JW-UBX5O2M-3MSZ2AT";
        };

        "Orion" = {
          id = "MGXVCCT-ZQFRL54-HPRDKKH-DJAONGC-ID3RZOX-GJYCBZF-LK7IIM4-5HMRCAH";
        };

        "Server" = {
          id = "VM5JQBF-WVJHXAD-7EGVDNR-OPTUXI5-ZOJFHJX-ZCJIPON-WVPONFO-I3D37AE";
        };
      };

      folders = {
        "Music" = {
          id = "music";
          path = "${home}/Music";
          devices = [
            "Notebook"
            "Orion"
            "Server"
          ];
          ignorePerms = false;
          ignorePatterns = [ "(?d).DS_Store" ];
          maxConflicts = 0;
        };

        "Obsidian" = {
          id = "obsidian";
          path = "${home}/Obsidian";
          devices = [
            # "Newton"
            "Notebook"
            "Orion"
            "Server"
          ];
          ignorePerms = false;
          ignorePatterns = [ "(?d).DS_Store" ];
          maxConflicts = 0;
        };

        "Sync" = {
          id = "sync";
          path = "${home}/Sync";
          devices = [
            # "Newton"
            "Notebook"
            "Orion"
            "Server"
          ];
          ignorePerms = false;
          ignorePatterns = [ "(?d).DS_Store" ];
          maxConflicts = 0;
        };

        "Wallpapers" = {
          id = "wallpapers";
          path = "${home}/Videos/Wallpapers";
          devices = [
            "Orion"
            "Server"
          ];
          ignorePerms = false;
          ignorePatterns = [ "(?d).DS_Store" ];
          maxConflicts = 0;
        };
      };

      options.urAccepted = -1;
    };
  };
}
