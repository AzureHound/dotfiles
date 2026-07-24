{ config, ... }:

let
  inherit (config.xdg) configHome;
in

{
  sops.secrets = {
    forge = {
      path = configHome + "/forge/config";
    };

    gust = {
      path = configHome + "/gust/auth.json";
    };

    # nix-auth-tokens = { };
  };
}
