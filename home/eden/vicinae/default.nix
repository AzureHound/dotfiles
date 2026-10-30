{
  pkgs,
  config,
  inputs,
  ...
}:

let
  mkMyVicinaeExt = pkgs.callPackage ./extension.nix { };
in

{
  disabledModules = [ "programs/vicinae" ];

  imports = [
    inputs.vicinae.homeManagerModules.default
  ];

  programs.vicinae = {
    enable = config.pixel.profiles.graphical.enable && pkgs.stdenv.hostPlatform.isDarwin;

    # NOTE: I only do it this way because I hate IFD, normal people should use
    # `config.lib.vicinae.mkExtension`
    extensions = map mkMyVicinaeExt [
      {
        extName = "nix";
        npmDepsHash = "sha256-TEyCCDjAtRYX2uH2TpLfe4/hTzyfMiyDhzVdyQXhEus=";
      }
    ];
  };
}
