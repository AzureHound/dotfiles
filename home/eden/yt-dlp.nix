{ config, ... }:

{
  programs.yt-dlp = {
    inherit (config.pixel.profiles.media.watching) enable;

    settings = {
      output = "~/Videos/yt-dlp/%(playlist|)s/%(playlist_index&{} - |)s%(title)s [%(id)s].%(ext)s";

      # extract-audio = true;
      no-playlist = true;

      no-check-certificate = true;
      remote-components = "ejs:github";

      sub-langs = "en.*";
      embed-thumbnail = true;
      embed-subs = true;
      embed-metadata = true;
      embed-chapter = true;

      sponsorblock-mark = "all";
      sponsorblock-chapter-title = "SponsorBlock: %(category_names)l";
    };
  };
}
