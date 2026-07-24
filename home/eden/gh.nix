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
    };

    gh-dash = {
      inherit (config.programs.gh) enable;

      settings = {
        pager.diff = "delta --dark --paging=never";
      };
    };
  };

  sops = {
    secrets.gh = { };

    templates."hosts.yml" = {
      path = "${config.home.homeDirectory}/.config/gh/hosts.yml";
      content = ''
        github.com:
          user: AzureHound
          oauth_token: ${config.sops.placeholder.gh}
          git_protocol: ssh
      '';
    };
  };
}
