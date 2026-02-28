{
  lib,
  _class,
  config,
  ...
}:

let
  inherit (lib.options) mkEnableOption;

  cfg = config.pixel.system.tools;
in

{
  options.pixel.system.tools = {
    enable = mkEnableOption "tools" // {
      default = true;
    };

    minimal = mkEnableOption "limit system tooling" // {
      default = true;
    };
  };

  config =
    if _class == "nixos" then
      {
        system = {
          disableInstallerTools = cfg.minimal;

          tools = {
            nixos-version.enable = true;
            nixos-rebuild = {
              enable = true;
              # enableRun0Elevation = true; # TODO:
            };
          };
        };
      }
    else
      {
        system.tools = {
          enable = !cfg.minimal;

          darwin-version.enable = true;
          darwin-rebuild.enable = true;
        };
      };
}
