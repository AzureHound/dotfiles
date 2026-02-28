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
      hashedPassword = "$y$j9T$9EGSlv35sd9B3iqE0G8Q5/$Cnh6k3.60CYGpNUcemFdQOj2AQDRb6f8RAm7QRTCG78";
    };
  };
}
