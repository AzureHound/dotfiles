{ pkgs, config, ... }:

{
  programs.jrnl = {
    inherit (config.pixel.profiles.graphical) enable;

    settings = {
      version = "v${pkgs.jrnl.version}";
      journals = {
        default = "~/Obsidian/jrnl/journal.txt";
        work = "~/Obsidian/jrnl/work.txt";
      };
      colors = {
        body = "none";
        date = "green";
        tags = "yellow";
        title = "cyan";
      };
      default_hour = 9;
      default_minute = 0;
      editor = "vim";
      encrypt = false;
      highlight = true;
      indent_character = "|";
      linewrap = 80;
      tagsymbols = "@";
      template = false;
      timeformat = "%Y-%m-%d %H:%M";
    };
  };
}
