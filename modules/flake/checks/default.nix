{ pkgs, inputs, ... }:

let
  inherit (pkgs) lib;

  scope = lib.makeScope pkgs.newScope (scopeSelf: {
    inherit (inputs) self;

    formatting = scopeSelf.callPackage ./formatting.nix { };

    selflib = scopeSelf.callPackage ./lib.nix { };
  });
in

lib.filterAttrs (_: lib.isDerivation) scope
