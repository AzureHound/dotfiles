{
  lib,
  config,
  osClass,
  osConfig,
  ...
}:

let
  inherit (lib.options) mkEnableOption;
in

{
  options.pixel.profiles.media = {
    editing.enable = mkEnableOption "Editing profile";
    listening.enable = mkEnableOption "Listening profile";
    streaming.enable = mkEnableOption "Streaming profile";

    watching.enable = mkEnableOption "Watching profile" // {
      default = config.pixel.profiles.graphical.enable && osClass == "nixos";
    };
  };

  config.pixel.profiles = {
    inherit (osConfig.pixel.profiles)
      graphical
      headless
      workstation
      laptop
      server
      ;
  };
}
