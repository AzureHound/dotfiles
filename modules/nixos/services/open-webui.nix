{
  lib,
  self,
  config,
  ...
}:

let
  inherit (lib.modules) mkIf;
  inherit (self.lib) mkServiceOption;

  cfg = config.pixel.services.open-webui;
in

{
  options.pixel.services.open-webui = mkServiceOption "open-webui" {
    port = 8040;
    domain = "ai.${config.networking.domain}";
  };

  config = mkIf cfg.enable {
    services = {
      open-webui = {
        enable = true;
        host = "127.0.0.1";
        inherit (cfg) port;

        environment = {
          DEFAULT_MODELS = "gemma4:12b";
          OLLAMA_API_BASE_URL = "http://127.0.0.1:${toString config.pixel.services.ollama.port}";
        };
      };

      nginx.virtualHosts.${cfg.domain}.locations."/" = {
        proxyPass = "http://127.0.0.1:${toString cfg.port}";
        proxyWebsockets = true;
      };
    };
  };
}
