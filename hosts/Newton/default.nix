{ name, ... }:

{
  home-manager.users.${name} = import ./home.nix;

  pixel = {
    profiles = {
      graphical.enable = true;
      workstation.enable = true;
    };
  };

  # networking.wakeOnLan.enable = true;
}
