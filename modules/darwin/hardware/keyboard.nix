{
  system = {
    keyboard = {
      enableKeyMapping = true;

      # NOTE: don't support remap capslock to both ctrl & esc at the same time
      remapCapsLockToControl = false;
      remapCapsLockToEscape = true;

      # layout: ctrl | command | alt
      swapLeftCommandAndLeftAlt = false;
    };

    defaults.NSGlobalDomain = {
      # F1, F2, etc. keys as standard func keys.
      "com.apple.keyboard.fnState" = true;

      AppleKeyboardUIMode = 3; # Mode 3 enables full keyb ctrl.

      ApplePressAndHoldEnabled = true;
      InitialKeyRepeat = 15; # min 15 [ 225 ms ], max 120 [ 1800 ms ]
      KeyRepeat = 3; # min 2 [ 30 ms ] max 120 [ 1800 ms ]
    };
  };
}
