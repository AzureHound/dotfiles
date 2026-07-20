{
  config,
  name,
  inputs,
  ...
}:

{
  imports = [ inputs.home-manager.darwinModules.home-manager ];

  home-manager.users.${name} = {
    programs.nh = {
      enable = true;

      flake = config.pixel.environment.flakePath;
    };

    home = {
      file.".hushlogin".text = "";

      shellAliases = {
        nixbuild = "nh darwin switch -a";
        # nixbuild = "nh darwin switch --update -a";
      };
    };
  };
}
