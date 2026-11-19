{ lib, ... }:

let
  inherit (lib.attrsets) mapAttrs;
  inherit (lib.modules) mkOptionDefault;

  mkService = name: defaults: {
    pixel.services.${name} = mapAttrs (_: mkOptionDefault) defaults;
  };
in

{
  inherit mkService;
}
