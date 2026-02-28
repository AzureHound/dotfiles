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
      _FXEnableColumnAutoSizing = true;
      FXPreferredViewStyle = "Nlsv";

      FXDefaultSearchScope = "SCcf"; # CWD by default
      FXEnableExtensionChangeWarning = false;
      FXRemoveOldTrashItems = true;

      CreateDesktop = false;
      ShowHardDrivesOnDesktop = true;
      ShowExternalHardDrivesOnDesktop = true;
      ShowMountedServersOnDesktop = true;
      ShowRemovableMediaOnDesktop = true;
      _FXSortFoldersFirstOnDesktop = true;
    };

    NSGlobalDomain = {
      NSDocumentSaveNewDocumentsToCloud = false;
      NSTableViewDefaultSizeMode = 2;
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
