{ inputs, ... }:

{
  imports = [ inputs.sops.nixosModules.sops ];

  sops = {
    age.keyFile = "/var/lib/sops-nix/key.txt";

    gnupg.sshKeyPaths = [ ];
  };
}
