{ name, ... }:

{
  imports = [
    ./${name}.nix
    ./mkuser.nix
    ./options.nix
  ];
}
