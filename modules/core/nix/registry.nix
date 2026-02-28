{ lib, inputs, ... }:

let
  inherit (lib.attrsets) filterAttrs attrValues mapAttrs;
  inherit (lib.modules) mkForce;
  inherit (lib.types) isType;

  flakeInputs = filterAttrs (name: value: (isType "flake" value) && (name != "self")) inputs;
in

{
  # https://github.com/NixOS/nixpkgs/pull/388090
  nixpkgs.flake.source = mkForce null;

  nix = {
    registry = mapAttrs (_: flake: { inherit flake; }) flakeInputs;
    nixPath = attrValues (mapAttrs (k: v: "${k}=flake:${v.outPath}") flakeInputs);
  };
}
