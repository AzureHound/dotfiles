{
  lib,
  pkgs,
  config,
  ...
}:

let
  inherit (lib.modules) mkIf;

  Theme = pkgs.writeText "tt-theme" ''
    bgcol: #24273A
    fgcol: #6E738D
    hicol: #8BD5CA
    hicol2: #EEE49F
    hicol3: #8AADF4
    errcol: #ED8796
  '';

  tt-wrapped = pkgs.writeShellScriptBin "tt" ''
    export TERM=xterm-256color

    exec ${pkgs.tt}/bin/tt -theme ${Theme} "$@"
  '';
in

{
  config = mkIf config.pixel.profiles.graphical.enable {
    home.packages = [ tt-wrapped ];
  };
}
