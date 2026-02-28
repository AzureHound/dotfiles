{ lib, ... }:

let
  inherit (lib.modules) mkDefault;
in

{
  services = {
    thermald.enable = true;
    smartd.enable = true;
    lvm.enable = mkDefault false;
  };
}
