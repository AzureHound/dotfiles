{ name, ... }:

{
  imports = [
    ./${name}.nix
    ./root.nix
  ];

  config = {
    users.mutableUsers = false;
  };
}
