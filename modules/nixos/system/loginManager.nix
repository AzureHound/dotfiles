{
  lib,
  pkgs,
  config,
  ...
}:

let
  inherit (lib.meta) getExe;
  inherit (lib.strings) concatStringsSep;

  sessionData = config.services.displayManager.sessionData.desktops;
  sessionPath = concatStringsSep ":" [
    "${sessionData}/share/wayland-sessions"
    "${sessionData}/share/xsessions"
  ];
in

{
  services.greetd = {
    inherit (config.pixel.profiles.graphical) enable;
    restart = true;
    useTextGreeter = true;

    settings.default_session = {
      user = "greeter";
      command = concatStringsSep " " [
        (getExe pkgs.tuigreet)
        "--time"
        "--time-format '%a, %d %b %Y - %H:%M'"
        "--remember"
        "--remember-user-session"
        "--asterisks"
        "--greeting 'NixOS'"
        "--window-padding 1"
        "--container-padding 2"
        "--theme 'border=white;text=blue;prompt=yellow;time=red;action=white;button=yellow;container=black;input=magenta'"
        "--sessions '${sessionPath}'"
      ];
    };
  };
}
