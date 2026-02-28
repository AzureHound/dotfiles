{ config, ... }:

{
  services.libinput = {
    enable = config.pixel.profiles.laptop.enable;

    mouse = {
      accelProfile = "flat";
      accelSpeed = "0";
      middleEmulation = false;
    };

    touchpad = {
      naturalScrolling = true;
      tapping = true;
      clickMethod = "clickfinger";
      disableWhileTyping = true;
    };
  };

  hardware = {
    # keyboard.qmk.enable = true;
    uinput.enable = true;
  };
}
