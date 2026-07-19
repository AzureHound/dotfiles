{
  pixel = {
    profiles = {
      development.enable = true;
      # pentesting.enable = true;

      media = {
        # editing.enable = true;
        listening.enable = true;
        # streaming.enable = true;
        watching.enable = true;
      };
    };
  };

  programs = {
    # chromium.enable = true;
    ghostty.enable = true;
    zen-browser.enable = true;
    zsh.enable = true;
  };

  services = {
    ollama.enable = true;
    syncthing.enable = true;
  };
}
