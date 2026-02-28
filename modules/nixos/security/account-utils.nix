# https://hedgedoc.grimmauld.de/s/P2_wvU0w58

{ lib, ... }:

let
  inherit (lib.modules) mkDefault;
in

{
  # systemd.settings.Manager.NoNewPrivileges = true;

  security.account-utils.enable = true;

  # https://github.com/NixOS/nixpkgs/pull/521536
  programs.fuse.enable = mkDefault false;
}
