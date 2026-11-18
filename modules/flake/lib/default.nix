# https://github.com/NixOS/nixpkgs/blob/77ee426a4da240c1df7e11f48ac6243e0890f03e/lib/default.nix

{
  lib,
  inputs,
  pkgsFor,
}:

lib.fixedPoints.makeExtensible (final: {
  fail2ban = import ./fail2ban.nix { inherit lib; };
  helpers = import ./helpers.nix { inherit lib; };
  mkHost = import ./mkhost.nix { inherit inputs lib pkgsFor; };
  secrets = import ./secrets.nix { inherit inputs; };
  services = import ./services.nix { inherit lib; };
  validators = import ./validators.nix { inherit lib; };

  inherit (final.fail2ban) journalJail;
  inherit (final.hardware) isx86Linux;
  inherit (final.helpers) mkPubs giturl;
  inherit (final.secrets) mkSecret;
  inherit (final.services) mkServiceOption;
  inherit (final.validators) anyHome;
})
