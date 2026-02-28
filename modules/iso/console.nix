{ pkgs, ... }:

{
  console = {
    font = "${pkgs.kbd}/share/consolefonts/LatArCyrHeb-19.psfu.gz";
    keyMap = "en";
  };
}
