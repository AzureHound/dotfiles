{
  lib,
  pkgs,
  config,
  ...
}:

let
  inherit (lib.modules) mkIf;
in

{
  config = mkIf config.pixel.system.containers.enable {
    containers.zeno = {
      autoStart = true;
      privateNetwork = true;
      macvlans = [ "enp7s0" ];

      config = {
        environment.systemPackages = with pkgs; [
          curl
          git
          vim
        ];

        users.users.Len = {
          isNormalUser = true;
          extraGroups = [ "wheel" ];
          initialPassword = "Snowflake";
        };

        networking = {
          interfaces."mv-enp7s0".ipv4.addresses = [
            {
              address = "10.10.0.40";
              prefixLength = 24;
            }
          ];
          defaultGateway = "10.10.0.1";
          nameservers = [ "1.1.1.1" ];
        };

        system.stateVersion = config.system.stateVersion;
      };
    };
  };
}
