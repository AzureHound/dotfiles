{
  lib,
  pkgs,
  config,
  inputs,
  inputs',
  ...
}:

let
  inherit (lib.modules) mkIf;
  inherit (pkgs.stdenv.hostPlatform) isLinux;

  spicePkgs = inputs'.spicetify.legacyPackages;
in

{
  imports = [ inputs.spicetify.homeManagerModules.spicetify ];

  config.programs.spicetify = {
    inherit (config.pixel.profiles.media.listening) enable;

    spotifyPackage =
      if pkgs.stdenv.hostPlatform.isLinux then pkgs.spotify.override { ffmpeg_4 = pkgs.ffmpeg; } else pkgs.spotify;

    theme = spicePkgs.themes.catppuccin;
    colorScheme = "macchiato";

    wayland = mkIf isLinux true;
    windowManagerPatch = mkIf isLinux true;

    enabledExtensions = with spicePkgs.extensions; [
      adblock
      aiBandBlocker
      copyToClipboard
      hidePodcasts
      # lastfm
      shuffle
      volumePercentage
    ];
  };
}
