{ pkgs, inputs, ... }:

{
  imports = [ inputs.neru.homeManagerModules.default ];

  services.neru = {
    enable = true;
    package = pkgs.neru-source;

    settings = {
      hotkeys = {
        "Super+Shift+Space" = "hints --action left_click";
        "Super+Shift+S" = "scroll";
      };

      hints = {
        strategy = "contour";
        chars = "fjdkslaghqweioprutymvnczxb";
      };

      theme = {
        name = "catppuccin_macchiato";
        font_family = "Maple Mono";
      };
    };
  };
}
