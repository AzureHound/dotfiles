{
  lib,
  self,
  pkgs,
  config,
  ...
}:

let
  inherit (lib.modules) mkIf mkForce;
in

{
  config = mkIf config.pixel.profiles.graphical.enable {
    services.displayManager = {
      sddm = {
        enable = true;
        theme = mkForce "sddm-astronaut-theme";
        package = pkgs.kdePackages.sddm;
        extraPackages = [ pkgs.kdePackages.qtmultimedia ];
        wayland.enable = true;
      };
    };

    environment.systemPackages = [
      (pkgs.sddm-astronaut.override {
        embeddedTheme = "hyprland_kath";
        themeConfig = {
          Background = "${self}/config/configHome/sddm/Mario.mp4";
          BackgroundPlaceholder = "${self}/config/configHome/sddm/Mario.jpg";

          HeaderTextColor = "#b7bdf8";
          DateTextColor = "#b7bdf8";
          TimeTextColor = "#b7bdf8";
          FormBackgroundColor = "#242455";
          LoginFieldBackgroundColor = "#111111";
          LoginFieldTextColor = "#b7bdf8";
          PasswordFieldTextColor = "#b7bdf8";

          WarningColor = "#ed8796";

          HoverUserIconColor = "#eed49f";
          HoverPasswordIconColor = "#eed49f";

          PartialBlur = false;
          HaveFormBackground = false;
          FormPosition = "center";
          HideVirtualKeyboard = true;
        };
      })
    ];
  };
}
