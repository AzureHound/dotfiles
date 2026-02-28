{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    libwebp
    m-cli
    uutils-coreutils-noprefix
  ];
}
