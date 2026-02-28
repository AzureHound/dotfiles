{
  lib,
  self,
  config,
  ...
}:

let
  inherit (lib.modules) mkIf;
in

{
  config = mkIf config.pixel.profiles.graphical.enable {
    programs.fastfetch = {
      enable = true;

      settings = {
        "$schema" = "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json";
        logo = {
          type = "kitty-icat";
          source = "${self}/config/configHome/fastfetch/img/nixos.png";
          height = 15;
          width = 40;
          padding = {
            top = 1;
            right = 7;
            left = 3;
          };
        };
        display = {
          separator = " ➜ ";
          color = "white";
        };
        modules = [
          {
            type = "custom";
            format = "{#90}╭──────────── Hardware Information ────────────╮";
          }
          {
            type = "cpu";
            key = "   CPU";
            keyColor = "blue";
            format = "{1} ({4}) @ {7} {8}";
          }
          {
            type = "board";
            key = "   Board";
            keyColor = "magenta";
          }
          {
            type = "gpu";
            format = "{2} {3}";
            key = "  󰢮 GPU";
            keyColor = "yellow";
          }
          {
            type = "memory";
            key = "   Memory";
            keyColor = "green";
          }
          {
            type = "disk";
            key = "  󰋊 Disk";
            keyColor = "cyan";
            format = "{1} / {2} ({3}) {9}";
          }
          {
            type = "display";
            key = "  󰍹 Display";
            keyColor = "white";
            format = "{1}x{2} @ {3}Hz";
          }
          "break"
          {
            type = "custom";
            format = "{#90}├──────────── Software Information ────────────┤";
          }
          {
            type = "os";
            key = "  󱄅 OS";
            keyColor = "blue";
          }
          {
            type = "kernel";
            key = "   Kernel";
            keyColor = "red";
          }
          {
            type = "shell";
            key = "   Shell";
            keyColor = "magenta";
          }
          {
            type = "wm";
            key = "   WM";
            keyColor = "cyan";
          }
          {
            type = "terminal";
            key = "   Terminal";
            keyColor = "yellow";
          }
          {
            type = "packages";
            key = "  󱄅 Packages";
            keyColor = "green";
          }
          {
            type = "command";
            key = "  󱦟 OS Age";
            keyColor = "white";
            text = "birth_install=$(stat -c %W /); current=$(date +%s); time_progression=$((current - birth_install)); days_difference=$((time_progression / 86400)); echo $days_difference days";
          }
          {
            type = "uptime";
            key = "  󱫐 Uptime";
            keyColor = "white";
          }
          {
            type = "custom";
            format = "{#90}╰──────────────────────────────────────────────╯";
          }
          {
            type = "custom";
            format = "              {#90}󰮯  {#37}󰊠  {#36}󰊠  {#35}󰊠  {#34}󰊠  {#33}󰊠  {#32}󰊠  {#31}󰊠 ";
          }
        ];
      };
    };

    home.shellAliases = {
      ff = "fastfetch";
    };
  };
}
