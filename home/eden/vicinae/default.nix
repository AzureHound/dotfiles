{
  lib,
  pkgs,
  config,
  inputs,
  ...
}:

let
  inherit (lib.modules) mkIf;

  mkMyVicinaeExt = pkgs.callPackage ./extension.nix { };
in

{
  disabledModules = [ "programs/vicinae" ];

  imports = [
    inputs.vicinae.homeManagerModules.default
  ];

  config =
    mkIf (config.programs.vicinae.enable && config.pixel.profiles.graphical.enable && pkgs.stdenv.hostPlatform.isDarwin)
      {
        programs.vicinae = {
          # NOTE: I only do it this way because I hate IFD, normal people should use
          # `config.lib.vicinae.mkExtension`
          extensions = map mkMyVicinaeExt [
            {
              extName = "nix";
              npmDepsHash = "sha256-TEyCCDjAtRYX2uH2TpLfe4/hTzyfMiyDhzVdyQXhEus=";
            }
          ];
        };
      };
}
