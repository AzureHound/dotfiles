{
  lib,
  self,
  config,
  ...
}:

let
  inherit (lib.meta) getExe;
  inherit (lib.modules) mkIf;

  cfg = "${self}/config/configHome/oh-my-posh";
in

{
  programs = {
    oh-my-posh = {
      inherit (config.programs.zsh) enable;

      enableBashIntegration = false;
      enableNushellIntegration = false;
      enableFishIntegration = false;
      enableZshIntegration = false;

      settings = builtins.fromTOML (
        builtins.readFile (
          cfg
          +
            # "/p10k.toml"
            "/zen.toml"
        )
      );
    };

    zsh.initContent = mkIf config.programs.zsh.enable ''
      if [[ "$TERM_PROGRAM" != "Apple_Terminal" ]]; then
        eval "$(${getExe config.programs.oh-my-posh.package} init zsh --config ${config.xdg.configHome}/oh-my-posh/config.json)"
      fi
    '';
  };
}
