{
  lib,
  config,
  inputs,
  ...
}:

let
  inherit (lib.modules) mkIf;
in

{
  imports = [ inputs.catppuccin.nixosModules.catppuccin ];

  config = {
    console.colors = mkIf config.pixel.profiles.graphical.enable [
      (if config.pixel.catppuccin.oled.enable then "000000" else "24273a")
      "ed8796"
      "a6da95"
      "eed49f"
      "8aadf4"
      "f5bde6"
      "8bd5ca"
      "b8c0e0"
      "5b6078"
      "ed8796"
      "a6da95"
      "eed49f"
      "8aadf4"
      "f5bde6"
      "8bd5ca"
      "a5adcb"
    ];
  };
}
