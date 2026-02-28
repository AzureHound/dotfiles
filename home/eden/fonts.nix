{ pkgs, ... }:

{
  pixel.style.fonts = {
    name = "Ioskeley Mono";
    package = pkgs.ioskeley-mono.normal-NF;
  };
}
