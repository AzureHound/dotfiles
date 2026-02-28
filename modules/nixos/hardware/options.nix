{ lib, ... }:

let
  inherit (lib.options) mkOption;
  inherit (lib) types;
in

{
  options.pixel.device = {
    monitors = mkOption {
      type = types.attrsOf (
        types.submodule {
          options = {
            res = mkOption {
              type = types.str;
              default = "1920x1080";
            };

            hz = mkOption {
              type = types.int;
              default = 60;
            };

            position = mkOption {
              type = types.str;
              default = "auto";
            };

            scale = mkOption {
              type = types.str;
              default = "auto";
            };

            bitdepth = mkOption {
              type = types.int;
              default = 8;
            };

            cm = mkOption {
              type = types.str;
              default = "srgb";
            };
          };
        }
      );
    };

    keyboard = mkOption {
      type = types.enum [
        "us"
        "gb"
      ];
      default = "us";
    };
  };
}
