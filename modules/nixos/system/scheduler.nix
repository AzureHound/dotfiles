{ pkgs, ... }:

{
  services.scx = {
    # inherit (config.pixel.profiles.workstation) enable;
    scheduler = "scx_bpfland";
    package = pkgs.scx.rustscheds;
  };
}
