{
  lib,
  pkgs,
  config,
  ...
}:

let
  inherit (lib.lists) optional;
in

{
  home.sessionPath = [
    "${config.home.homeDirectory}/.local/bin"
    "${config.home.homeDirectory}/.dotnet/tools"
    "${config.home.homeDirectory}/.yarn/bin"
  ]
  ++ optional pkgs.stdenv.hostPlatform.isDarwin "$GHOSTTY_BIN_DIR";
}
