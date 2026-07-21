{
  lib,
  config,
  osConfig,
  ...
}:

let
  inherit (lib.modules) mkIf;
in

{
  config = mkIf config.services.ollama.enable {
    services.ollama = {
      host = "127.0.0.1";
      port = 11434;
      acceleration = if (osConfig.pixel.device.gpu or null) == "nvidia" then "cuda" else null;
    };
  };
}
