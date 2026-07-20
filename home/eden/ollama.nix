{
  lib,
  pkgs,
  config,
  osConfig,
  ...
}:

let
  inherit (lib.modules) mkIf;

  inherit (pkgs.stdenv.hostPlatform) isLinux;

  host = "127.0.0.1";
  port = 11434;

  loadModels = [
    # "deepseek-r1:8b"
    "gemma4:12b"
    # "qwen2.5-coder:7b"
    "qwen2.5-coder:14b"
    "qwen3:14b-q4_K_M"
  ];

  syncModels = true;

  ollama = lib.getExe pkgs.ollama;
  awk = lib.getExe pkgs.gawk;
  sed = lib.getExe pkgs.gnused;
  nproc = lib.getExe' pkgs.coreutils "nproc";
  xargs = lib.getExe' pkgs.findutils "xargs";

  declaredModelsRegex = lib.pipe loadModels [
    (map lib.escapeRegex)
    (lib.concatStringsSep "|")
    (lib.escape [ "/" ])
    lib.escapeShellArg
  ];

  pullScript = pkgs.writeShellScript "ollama-model-loader" ''
    export OLLAMA_HOST="${host}:${toString port}"

    ${lib.optionalString syncModels ''
      installed=$('${ollama}' list | '${awk}' 'NR > 1 {print $1}')
      ${
        if loadModels != [ ] then
          ''
            undeclared=$(echo "$installed" | '${sed}' -E /${declaredModelsRegex}/d)
          ''
        else
          ''
            undeclared="$installed"
          ''
      }
      if [ -n "$undeclared" ]; then
        '${ollama}' rm $undeclared
      fi
    ''}

    ${lib.optionalString (loadModels != [ ]) ''
      printf "%s\0" ${lib.escapeShellArgs loadModels} | '${xargs}' -0 -r -n 1 -P "$('${nproc}')" '${ollama}' pull
    ''}
  '';
in

{
  config = mkIf config.services.ollama.enable {
    services.ollama = {
      inherit host port;
      acceleration = if (osConfig.pixel.device.gpu or null) == "nvidia" then "cuda" else null;
    };

    systemd.user.services.ollama-model-loader = mkIf isLinux {
      Unit = {
        After = [ "ollama.service" ];
        BindsTo = [ "ollama.service" ];
      };
      Install.WantedBy = [ "default.target" ];
      Service = {
        Type = "exec";
        ExecStart = "${pullScript}";
        Restart = "on-failure";
        RestartSec = "1s";
        RestartMaxDelaySec = "2h";
        RestartSteps = "10";
      };
    };

    launchd.agents.ollama-model-loader = mkIf pkgs.stdenv.hostPlatform.isDarwin {
      enable = true;
      config = {
        ProgramArguments = [ "${pullScript}" ];
        RunAtLoad = true;
      };
    };
  };
}
