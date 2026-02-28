{
  lib,
  pkgs,
  config,
  ...
}:

let
  inherit (lib.modules) mkIf;
  inherit (lib.options) mkEnableOption;

  cfg = config.pixel.system.printing;
in

{
  options.pixel.system.printing = {
    enable = mkEnableOption "printing";
  };

  config = mkIf cfg.enable {
    services = {
      printing = {
        enable = true;

        drivers = with pkgs; [
          cnijfilter2
          ghostscript_headless
          gutenprint
          # hplip
        ];
      };

      # Network discovery
      avahi = {
        enable = true;
        nssmdns4 = true;
        nssmdns6 = true;
        openFirewall = true;
      };
    };
  };
}
