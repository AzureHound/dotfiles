{ config, ... }:

{
  programs = {
    gh = {
      enable = config.pixel.profiles.development.enable && config.programs.git.enable;
      gitCredentialHelper.enable = false;

      settings = {
        git_protocol = "ssh";
        pager = "delta --dark --paging=never";
        color_labels = "enabled";

        aliases = {
          co = "pr checkout";
          pv = "pr view";
        };
      };

      hosts = {
        "github.com" = {
          git_protocol = "ssh";
          user = "AzureHound";
          users = {
            AzureHound = {
              git_protocol = "ssh";
            };
          };
        };
      };
    };

    gh-dash = {
      inherit (config.programs.gh) enable;

      settings = {
        pager.diff = "delta --dark --paging=never";
      };
    };
  };
}
