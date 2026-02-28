{ config, ... }:

{
  programs.nh = {
    enable = true;

    # clean = {
    #   enable = true;
    #   dates = "weekly";
    #   extraArgs = "--keep-since 10d --keep 10";
    # };

    flake = config.pixel.environment.flakePath;
  };
}
