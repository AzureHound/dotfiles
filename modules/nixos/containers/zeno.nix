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
      hostAddress = "10.10.10.1";
      localAddress = "10.10.10.2";

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

        system.stateVersion = config.system.stateVersion;
      };
    };
  };
}
