{
  lib,
  pkgs,
  _class,
  ...
}:

let
  inherit (lib.lists) optionals;

  sudoers = if (_class == "nixos") then "@wheel" else "@admin";
in

{
  nix = {
    # package = pkgs.nixVersions.latest;

    channel.enable = false;

    gc = {
      automatic = true;
      options = "--delete-older-than 7d"; # "--delete-generations +5";
    };

    # https://docs.lix.systems/manual/lix/nightly/command-ref/conf-file.html
    settings = {
      experimental-features = [
        "flakes"
        "nix-command"
        "git-hashing"
        "pipe-operators"
      ]
      ++ optionals (_class == "nixos") [
        "auto-allocate-uids"
        "cgroups"
      ];

      system-features = [
        "recursive-nix"
        "big-parallel"
      ]
      ++ optionals (_class == "nixos") [
        "nixos-test"
        "kvm"
        # https://github.com/NixOS/nixpkgs/blob/master/nixos/doc/manual/development/running-nixos-tests.section.md#system-requirements-sec-running-nixos-tests-requirements
        "uid-range"
      ];

      allowed-users = [ sudoers ];
      trusted-users = [ sudoers ];

      # https://x.com/puckipedia/status/1693927716326703441
      accept-flake-config = false;

      # https://github.com/NixOS/nix/issues/7273
      auto-optimise-store = true;

      min-free = 5 * 1024 * 1024 * 1024;
      max-free = 20 * 1024 * 1024 * 1024;

      sandbox = pkgs.stdenv.hostPlatform.isLinux;

      max-jobs = "auto";
      http-connections = 50;

      allow-import-from-derivation = true;
      keep-derivations = true;
      keep-outputs = true;

      flake-registry = "";
      use-registries = true;

      # fallback = true;

      log-lines = 30;
      warn-dirty = false;
      keep-going = true;

      use-xdg-base-directories = true;
    };
  };
}
