{
  system.defaults = {
    finder = {
      NewWindowTarget = "Home";
      QuitMenuItem = true;

      AppleShowAllFiles = true;
      AppleShowAllExtensions = true;

      # _FXShowPosixPathInTitle = true;
      # ShowPathbar = true;
      # ShowStatusBar = true;

      _FXSortFoldersFirst = true;
      # _FXEnableColumnAutoSizing = true;
      FXPreferredViewStyle = "Nlsv";

      FXDefaultSearchScope = "SCcf";
      FXEnableExtensionChangeWarning = false;
      FXRemoveOldTrashItems = true;

      # CreateDesktop = false;
      ShowHardDrivesOnDesktop = true;
      ShowExternalHardDrivesOnDesktop = true;
      ShowMountedServersOnDesktop = true;
      ShowRemovableMediaOnDesktop = true;
      _FXSortFoldersFirstOnDesktop = true;
    };

    NSGlobalDomain = {
      NSTableViewDefaultSizeMode = 2;
      NSDocumentSaveNewDocumentsToCloud = false;
    };

    CustomUserPreferences."com.apple.finder" = {
      DesktopViewSettings = {
        IconViewSettings = {
          arrangeBy = "name";
        };
      };

      StandardViewSettings = {
        IconViewSettings = {
          arrangeBy = "name";
        };
      };

      FK_StandardViewSettings = {
        IconViewSettings = {
          arrangeBy = "name";
        };
      };

      WarnOnEmptyTrash = false;
    };
  };
}
