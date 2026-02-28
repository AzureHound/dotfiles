{ self, config, ... }:

let
  inherit (self.lib) anyHome;

  qh = anyHome config;
in

{
  programs = {
    fish = {
      enable = qh (c: c.programs.fish.enable);

      useBabelfish = true;
    };

    zsh.enable = qh (c: c.programs.zsh.enable);
  };
}
