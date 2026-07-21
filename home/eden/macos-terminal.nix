{ pkgs, name, ... }:

{
  programs.macos-terminal = {
    enable = pkgs.stdenv.hostPlatform.isDarwin;

    preferences = {
      importSettings = true;
      writeFile = false;
    };

    profiles."${name}".settings = {
      FontAntialias = true;
      ShowActiveProcessInTitle = true;
      # ShowCommandKeyInTitle = true;
      inherit name;
      rowCount = 34;
      columnCount = 126;
    };
  };
}
