# config options: https://daiderd.com/nix-darwin/manual/index.html#sec-options
# macOS `defaults` commands: https://macos-defaults.com/

# https://github.com/rgcr/m-cli

# `defaults read` or `defaults read xxx`

{
  imports = [
    ./clock.nix
    ./controlcenter.nix
    ./dock.nix
    ./finder.nix
    ./images.nix
    ./info.nix
    ./login.nix
    ./measurements.nix
    ./misc.nix
    ./power.nix
    ./sound.nix
    ./theme.nix
    ./wm.nix
  ];
}
