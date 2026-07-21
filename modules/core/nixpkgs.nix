{ pkgs, ... }:

{
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;

      permittedInsecurePackages = [];

      allowAliases = false;
      allowBroken = false;
      allowUnsupportedSystem = false;
      allowVariants = false;

      # showDerivationWarnings = [ "maintainerless" ];
    };
  };

  # assertions = [
  #   {
  #     assertion = pkgs.overlays == [ ];
  #     message = "nixpkgs overlays are not allowed in my config.";
  #   }
  # ];
}
