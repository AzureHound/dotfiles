{
  lib,
  config,
  ...
}:

let
  inherit (lib.modules) mkIf;
  inherit (lib.options) mkEnableOption;

  cfg = config.pixel.system.containers;
in

{
  imports = [
    ./xeno.nix
    ./zeno.nix
  ];

  options.pixel.system.containers = {
    enable = mkEnableOption "containers";
  };

  config = mkIf cfg.enable {
    networking = {
      firewall.trustedInterfaces = [ "ve-+" ];

      nat = {
        enable = true;
        internalInterfaces = [ "ve-+" ];
        externalInterface = "enp7s0";
        enableIPv6 = true;
      };
    };
  };
}
