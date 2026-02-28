{ pkgs, ... }:

{
  plugins.render-markdown = {
    enable = true;
    lazyLoad.settings.ft = [ "markdown" ];

    settings = {
      completions.blink.enabled = true;
      heading.icons = [
        "󰎤 "
        "󰎧 "
        "󰎪 "
        "󰎭 "
        "󰎱 "
        "󰎳 "
      ];
    };
  };

  extraPackages = with pkgs; [ tectonic ];
}
