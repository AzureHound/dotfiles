{
  lib,
  pkgs,
  config,
  ...
}:

let
  inherit (lib.attrsets) genAttrs;
  inherit (lib.modules) mkIf mkMerge;

  services = [
    "login"
    "greetd"
    "tuigreet"
  ];

  mkService = {
    enableGnomeKeyring = true;
    gnupg = {
      enable = true;
      noAutostart = true;
      storeOnly = true;
    };
  };
in

{
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;

    pinentryPackage = pkgs.writeShellScriptBin "pinentry-env" ''
      if [ "$PINENTRY_USER_DATA" = "curses" ]; then
        exec ${pkgs.pinentry-curses}/bin/pinentry-curses "$@"
      else
        exec ${pkgs.pinentry-gnome3}/bin/pinentry-gnome3 "$@"
      fi
    '';

    settings = {
      default-cache-ttl = 21600;
      default-cache-ttl-ssh = 21600;
      max-cache-ttl = 64800;
      max-cache-ttl-ssh = 64800;
    };
  };

  security.pam = mkMerge [
    {
      # Fix "too many files open" errors
      loginLimits = [
        {
          domain = "@wheel";
          item = "nofile";
          type = "soft";
          value = "524288";
        }
        {
          domain = "@wheel";
          item = "nofile";
          type = "hard";
          value = "1048576";
        }
      ];

      services = {
        hyprlock.text = "auth include login";
        swaylock.text = "auth include login";
      };
    }

    (mkIf config.pixel.profiles.graphical.enable {
      services = genAttrs services (_: mkService);
    })
  ];
}
