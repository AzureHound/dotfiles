{ lib, ... }:

let
  inherit (lib.modules) mkForce;
in

{
  systemd.services.sshd.wantedBy = mkForce [ "multi-user.target" ];

  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPyoX1ZlGb9FFtu9Xw8GE8C+GkwExi03xHZ0LSPnD6zw"
  ];
}
