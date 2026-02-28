{
  lib,
  config,
  mkHomeLink,
  ...
}:

let
  inherit (lib.modules) mkIf;
in

{
  programs.password-store = {
    inherit (config.pixel.profiles.workstation) enable;

    settings = {
      PASSWORD_STORE_DIR = "${config.home.homeDirectory}/.password-store";
    };
  };

  home.file = mkIf config.programs.password-store.enable (mkHomeLink [ ".password-store" ]);
}
