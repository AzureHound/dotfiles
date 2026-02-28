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
  config = mkIf config.services.openssh.enable {
    environment.systemPackages = with pkgs; [
      foot.terminfo
      kitty.terminfo
      ghostty.terminfo
    ];
  };
}
