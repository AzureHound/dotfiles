# WARNING: EXPERIMENTAL

{
  services.userborn.enable = true;

  system = {
    # https://github.com/NixOS/nixpkgs/blob/9bf13c9c35c9e80fab6fa3161ec0a09c1ec9a3be/pkgs/by-name/ni/nixos-init/README.md
    nixos-init.enable = true;

    activatable = true;

    # mount /etc as read-only overlay filesystem
    etc.overlay.enable = true;
  };
}
