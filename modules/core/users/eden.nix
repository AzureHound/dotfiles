{
  lib,
  name,
  config,
  ...
}:

let
  inherit (lib.lists) elem;
  inherit (lib.modules) mkIf;
in

{
  config = mkIf (elem name config.pixel.system.users) {
    users.users.${name} = {
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPyoX1ZlGb9FFtu9Xw8GE8C+GkwExi03xHZ0LSPnD6zw"
      ];
    };
  };
}
