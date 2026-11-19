# https://github.com/NixOS/nixpkgs/blob/77ee426a4da240c1df7e11f48ac6243e0890f03e/lib/default.nix

{
  lib,
  inputs,
  pkgsFor,
}:

lib.fixedPoints.makeExtensible (final: {
  helpers = import ./helpers.nix { inherit lib; };
  mkHost = import ./mkhost.nix { inherit inputs lib pkgsFor; };
  modules = import ./modules.nix { inherit lib inputs; };
  validators = import ./validators.nix { inherit lib; };

  inherit (final.hardware) isx86Linux;
  inherit (final.helpers) mkPubs giturl;
  inherit (final.modules) mkService mkSecret journalJail;
  inherit (final.validators) anyHome;
})
