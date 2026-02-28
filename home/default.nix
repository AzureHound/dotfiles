{
  lib,
  self,
  self',
  pkgs,
  name,
  config,
  inputs,
  inputs',
  ...
}:

let
  inherit (lib.attrsets) genAttrs;
in

{
  home-manager = {
    verbose = true;
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "bak";

    users = genAttrs config.pixel.system.users (name: {
      imports = [ ./${name} ];

      home = {
        username = name;
        homeDirectory = if pkgs.stdenv.hostPlatform.isLinux then "/home/${name}" else "/Users/${name}";
      };
    });

    extraSpecialArgs = {
      inherit
        inputs
        inputs'
        name
        self
        self'
        ;

      mkpkg = import ./${name}/pkgs { inherit pkgs; };
    };

    sharedModules = [ (self + /modules/home) ];
  };
}
