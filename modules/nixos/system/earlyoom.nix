{
  lib,
  pkgs,
  config,
  ...
}:

let
  inherit (lib.modules) mkIf mkForce;
  inherit (lib.strings) concatStringsSep;

  avoid = concatStringsSep "|" [
    "(h|H)yprland"
    "sway"
    "Xwayland"
    "cryptsetup"
    "dbus-.*"
    "gpg-agent"
    "greetd"
    "ssh-agent"
    ".*qemu-system.*"
    "sddm"
    "sshd"
    "systemd"
    "systemd-.*"
    "kitty"
    "ghostty"
    "bash"
    "zsh"
    "fish"
    "n?vim"
    "akkoma"
  ];

  prefer = concatStringsSep "|" [
    "Web Content"
    "Isolated Web Co"
    "firefox.*"
    "chrom(e|ium).*"
    "electron"
    "dotnet"
    ".*.exe"
    "java.*"
    "pipewire(.*)"
    "nix"
    "npm"
    "node"
  ];
in

{
  config = mkIf config.pixel.profiles.graphical.enable {
    # https://dataswamp.org/~solene/2022-09-28-earlyoom.html
    services = {
      earlyoom = {
        enable = true;
        enableNotifications = true;

        reportInterval = 0;
        freeSwapThreshold = 5;
        freeSwapKillThreshold = 2;
        freeMemThreshold = 5;
        freeMemKillThreshold = 2;

        extraArgs = [
          "-g"
          "--avoid"
          "'^(${avoid})$'"
          "--prefer"
          "'^(${prefer})$'"
        ];

        killHook = pkgs.writeShellScript "earlyoom-kill-hook" ''
          echo "Process $EARLYOOM_NAME ($EARLYOOM_PID) was killed"
        '';
      };

      systembus-notify.enable = mkForce true;
    };
  };
}
