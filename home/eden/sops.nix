{ config, ... }:

let
  inherit (config.xdg) configHome;
in

{
  sops.secrets = {
    gust = {
      path = configHome + "/gust/auth.json";
    };

    # nix-auth-tokens = { };
  };
}
