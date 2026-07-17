{
  system.defaults = {
    LaunchServices.LSQuarantine = false;
    SoftwareUpdate.AutomaticallyInstallMacOSUpdates = false;
    hitoolbox.AppleFnUsageType = "Show Emoji & Symbols";

    screensaver = {
      askForPassword = true;
      askForPasswordDelay = 0;
    };

    universalaccess = {
      reduceMotion = true;
      # reduceTransparency = true;
    };

    NSGlobalDomain = {
      AppleScrollerPagingBehavior = true;
      AppleShowScrollBars = "WhenScrolling";

      # NSAutomaticWindowAnimationsEnabled = false;
      NSDisableAutomaticTermination = true;
      NSWindowShouldDragOnGesture = true;
      # NSCloseAlwaysConfirmsChanges = false;
      # NSQuitAlwaysKeepsWindows = false;

      NSNavPanelExpandedStateForSaveMode = true;
      NSNavPanelExpandedStateForSaveMode2 = true;

      PMPrintingExpandedStateForPrint = true;
      PMPrintingExpandedStateForPrint2 = true;

      NSAutomaticCapitalizationEnabled = false;
      NSAutomaticDashSubstitutionEnabled = false;
      NSAutomaticInlinePredictionEnabled = true;
      NSAutomaticPeriodSubstitutionEnabled = false;
      NSAutomaticQuoteSubstitutionEnabled = false;
      NSAutomaticSpellingCorrectionEnabled = true;

      iCal."first day of week" = "Monday";
    };

    CustomUserPreferences = {
      # Add context menu item showing Web Inspector in web view
      NSGlobalDomain.WebKitDeveloperExtras = true;

      "com.apple.CloudSubscriptionFeatures.option" = {
        "545129924" = false;
      };

      "com.apple.commerce".AutoUpdate = true;

      "com.apple.desktopservices" = {
        # .DS_Store
        DSDontWriteNetworkStores = true;
        DSDontWriteUSBStores = true;
      };

      "com.apple.TimeMachine".DoNotOfferNewDisksForBackup = true;

      "com.apple.SoftwareUpdate" = {
        AutomaticCheckEnabled = true;
        AutomaticDownload = 0;
        CriticalUpdateInstall = 1;
        ScheduleFrequency = 7;
      };

      "com.apple.Terminal".FocusFollowsMouse = true;
    };
  };
}
