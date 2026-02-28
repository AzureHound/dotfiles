{
  system.defaults = {
    NSGlobalDomain.AppleICUForce24HourTime = true;

    menuExtraClock = {
      Show24Hour = true;
      ShowAMPM = false;
      IsAnalog = false;

      # 0 = Show date | 1 = Don’t show | 2 = Don’t show [ Hide date ]
      ShowDate = 0;

      # ShowSeconds = false;
      ShowDayOfWeek = true;
      ShowDayOfMonth = true;
    };
  };
}
