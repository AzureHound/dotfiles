{ lib, ... }:

let
  inherit (lib.options) mkOption;
  inherit (lib) types;
in

{
  imports = [
    ./amd.nix
    ./intel.nix
    ./nvidia.nix
  ];

  options.pixel.device.gpu = mkOption {
    type = types.nullOr (
      types.enum [
        "amd"
        "intel"
        "nvidia"
      ]
    );
    default = null;
  };
}
