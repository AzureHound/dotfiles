{ lib, ... }:

let
  inherit (lib.options) mkEnableOption;
in

{
  imports = [
    ./xeno.nix
    ./zeno.nix
  ];

  options.pixel.system.containers = {
    enable = mkEnableOption "containers";
  };
}
