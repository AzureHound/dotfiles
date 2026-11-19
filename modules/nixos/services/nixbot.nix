{
  lib,
  self,
  config,
  inputs,
  ...
}:

let
  inherit (lib.modules) mkIf;
  inherit (self.lib) mkSecret mkService;

  inherit (config.sops) secrets;

  rdomain = config.networking.domain;

  cfg = config.pixel.services.nixbot;
in

{
  imports = [
    inputs.nixbot.nixosModules.default
    (mkService "nixbot" { domain = "ci.${rdomain}"; })
  ];

  config = mkIf cfg.enable {
    sops.secrets = {
      nixbot-gh-webhook-secret = mkSecret {
        file = "nixbot";
        key = "gh-webhook-secret";
      };
      nixbot-gh-private-key = mkSecret {
        file = "nixbot";
        key = "gh-private-key";
      };
      nixbot-gh-oauth = mkSecret {
        file = "nixbot";
        key = "gh-oauth";
      };
    };

    services = {
      nixbot = {
        enable = true;
        inherit (cfg) domain;
        statusContextPrefix = "buildbot";
        buildSystems = [ "x86_64-linux" ];

        admins = [ "github:azurehound" ];

        github = {
          enable = true;

          appId = 1153859;
          secretKeyFile = secrets.nixbot-gh-private-key.path;

          oauthId = "Iv23liSeLy6J7IS9awg1";
          oauthSecretFile = secrets.nixbot-gh-oauth.path;

          webhookSecretFile = secrets.nixbot-gh-webhook-secret.path;
        };
      };

      nginx.virtualHosts.${cfg.domain} = { };
    };
  };
}
