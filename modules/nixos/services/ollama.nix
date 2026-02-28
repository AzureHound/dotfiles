{
  lib,
  self,
  config,
  ...
}:

let
  inherit (lib.modules) mkIf;
  inherit (self.lib) mkServiceOption;

  cfg = config.pixel.services.ollama;
in

{
  options.pixel.services.ollama = mkServiceOption "ollama" {
    port = 11434;
  };

  config = mkIf cfg.enable {
    services.ollama = {
      enable = true;

      host = "127.0.0.1";
      inherit (cfg) port;

      loadModels = [
        # "deepseek-r1:8b"
        "gemma4:12b"
        # "qwen2.5-coder:7b"
        "qwen2.5-coder:14b"
        "qwen3:14b-q4_K_M"
      ];
    };
  };
}
