{
  lib,
  pkgs,
  config,
  ...
}:

let
  inherit (lib.modules) mkIf;
in

{
  config = mkIf (pkgs.stdenv.hostPlatform.isLinux && config.pixel.profiles.graphical.enable) {
    programs.libreoffice = {
      # settings = {
      #   "/org.openoffice.Office.Common/Filter/PDF/Export" = {
      #     PDFUACompliance = true;
      #   };
      # };
    };
  };
}
