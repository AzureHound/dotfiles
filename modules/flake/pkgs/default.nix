{ pkgs, inputs, ... }:

removeAttrs (pkgs.lib.customisation.makeScope pkgs.newScope (self: {
  inherit inputs;

  mushroom-strategy = self.callPackage ./mushroom-strategy/pkg.nix { };

  update-pins = self.callPackage ./update-pins/pkg.nix { };
})) [ "inputs" ]
