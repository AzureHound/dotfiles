{ pkgs, ... }:

{
  services.scx-loader = {
    # inherit (config.pixel.profiles.workstation) enable;
    schedsPackages = [ pkgs.scx.rustscheds ];
    config.default_sched = "scx_bpfland";
  };
}
