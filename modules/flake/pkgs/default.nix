{ pkgs, inputs, ... }:

removeAttrs (pkgs.lib.customisation.makeScope pkgs.newScope (self: {
  inherit inputs;

  chip-ota-provider-app = self.callPackage ./chip-ota-provider-app/pkg.nix { };

  update-pins = self.callPackage ./update-pins/pkg.nix { };
})) [ "inputs" ]
