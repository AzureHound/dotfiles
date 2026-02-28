{
  config,
  inputs,
  osConfig,
  ...
}:

{
  imports = [ inputs.catppuccin.homeModules.catppuccin ];

  config = {
    catppuccin = {
      inherit (config.pixel.profiles.workstation) enable;
      autoEnable = true;

      flavor = "macchiato";
      accent = "blue";

      sources = if (osConfig ? catppuccin) then osConfig.catppuccin.sources else config.catppuccin.sources;
    };
  };
}
