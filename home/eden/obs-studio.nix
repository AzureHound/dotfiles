{ pkgs, config, ... }:

{
  programs.obs-studio = {
    inherit (config.pixel.profiles.media.streaming) enable;

    package = pkgs.obs-studio.override {
      cudaSupport = true;
    };

    plugins = with pkgs.obs-studio-plugins; [
      obs-move-transition
      obs-multi-rtmp
      obs-pipewire-audio-capture
      wlrobs
    ];
  };

  # Theme
  catppuccin.obs.enable = true;
}
