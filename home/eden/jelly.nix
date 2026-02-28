{
  lib,
  pkgs,
  mkpkg,
  config,
  ...
}:

let
  inherit (lib.modules) mkIf;

  inherit (config.xdg) configHome;
in

{
  config = mkIf config.pixel.profiles.media.watching.enable {
    home.packages = with pkgs; [ mkpkg.jelly ];

    sops.secrets.jelly = { };

    sops.templates."jelly-config" = {
      path = "${configHome}/jelly/config";
      content = ''
        server=http://10.10.0.5:8096
        api_key=${config.sops.placeholder.jelly}
        editor=vim
        media_preview=true
        player=mpv
        autoplay_next_episode=true
        mark_continue_percentage=5
        mark_watched_percentage=95

        FZF_DEFAULT_OPTS='
          --color=fg:#cad3f5,fg+:#cad3f5,bg:-1,bg+:-1,gutter:#24273a
          --color=header:#8aadf4,hl:#eed49f,hl+:#a6da95,query:#a6da95
          --color=prompt:#c6a0f6,pointer:#a6da95,info:#f4dbd6
          --color=border:#494d64,separator:#b7bdf8,scrollbar:#f0c6c6
          --prompt="󰥨 Search: " --pointer="❯" --separator="─" --scrollbar="│"
          --height=100% --padding=1
        '
      '';
    };
  };
}
