{ pkgs, config, ... }:

{
  programs.opencode = {
    inherit (config.pixel.profiles.development) enable;

    web = {
      enable = true;
      # environmentFile = "/run/secrets/opencode-web";
    };

    settings = {
      autoupdate = false;

      model = "ollama/gemma4:12b";

      server = {
        hostname = "0.0.0.0";
        port = 4096;
        mdns = true;
        mdnsDomain = "opencode.local";
        cors = [ "http://localhost:5173" ];
      };

      shell = "${pkgs.zsh}/bin/zsh";

      tools = {
        bash = true;
      };

      permission = {
        "*" = "ask";
        "edit" = "ask";
        "webfetch" = "allow";
        "bash" = "ask";
      };

      watcher = {
        ignore = [
          "node_modules/**"
          "dist/**"
          ".git/**"
        ];
      };

      provider = {
        ollama = {
          npm = "@ai-sdk/openai-compatible";
          options = {
            baseURL = "http://127.0.0.1:11434/v1";
            timeout = 1200000;
            headerTimeout = 1200000;
          };
          models = {
            "gemma4:12b" = { };
          };
        };
      };
    };
  };
}
