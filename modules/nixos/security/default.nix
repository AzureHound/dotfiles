# https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/profiles/hardened.nix
# https://github.com/fort-nix/nix-bitcoin/blob/master/modules/presets/hardened-extended.nix

{
  imports = [
    # ./account-utils.nix
    ./apparmor.nix
    ./auditd.nix
    ./clamav.nix
    ./login-defs.nix
    ./pam.nix
    ./polkit.nix
    # ./run0.nix
    ./sudo.nix
  ];
}
