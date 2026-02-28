{ inputs, ... }:

{
  # Prevent rebuilds
  system.switch.enable = false;

  # Fix "too many open files"
  security.pam.loginLimits = [
    {
      domain = "*";
      item = "nofile";
      type = "-";
      value = "65536";
    }
  ];

  # Fix annoying warnings
  environment.etc = {
    "nix/flake-channels/nixpkgs".source = inputs.nixpkgs;

    "mdadm.conf".text = ''
      MAILADDR root
    '';
  };
}
