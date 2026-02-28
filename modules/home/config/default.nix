{
  lib,
  self,
  config,
  ...
}:

let
  inherit (lib.attrsets) genAttrs;
  inherit (lib.modules) mkIf mkMerge;

  appsDir = "${self}/config/home/.local/share/applications";
  cfg = "${config.home.homeDirectory}/Developer/dotfiles";
in

{
  imports = [
    ./Home.nix
    ./configHome.nix
  ];

  options.ign.desktop = lib.mkOption {
    type = lib.types.listOf lib.types.str;
    default = [ ];
  };

  config = mkMerge [
    {
      _module.args = {
        mkHomeLink =
          files:
          genAttrs files (f: {
            source = config.lib.file.mkOutOfStoreSymlink "${cfg}/config/home/${f}";
          });

        mkCfgLink =
          files:
          genAttrs files (f: {
            source = config.lib.file.mkOutOfStoreSymlink "${cfg}/config/configHome/${f}";
          });

        mkIgLink =
          ignored:
          builtins.listToAttrs (
            map (name: {
              name = "applications/${name}";
              value = {
                source = "${appsDir}/${name}";
              };
            }) (builtins.filter (n: !(builtins.elem n ignored)) (builtins.attrNames (builtins.readDir appsDir)))
          );
      };

      home.activation = {
        mkDeveloper = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
          mkdir -p ${config.home.homeDirectory}/Developer
        '';

        mkDirectories = mkIf config.pixel.profiles.graphical.enable (
          lib.hm.dag.entryAfter [ "writeBoundary" ] ''
            mkdir -p ${config.home.homeDirectory}/Archive \
              "${config.xdg.dataHome}/Lyrics"
          ''
        );
      };
    }
  ];
}
