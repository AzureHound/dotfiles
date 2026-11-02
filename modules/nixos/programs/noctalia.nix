{
  lib,
  self,
  pkgs,
  config,
  inputs,
  ...
}:

let
  inherit (lib.modules) mkIf;
  inherit (self.lib) anyHome;

  cond = anyHome config (conf: conf.programs.noctalia.enable);
in

{
  config = mkIf cond {
    environment.systemPackages = [
      inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];
  };
}
