{ pkgs, inputs, ... }:

{
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;

      permittedInsecurePackages = [ ];

      allowAliases = false;
      allowBroken = false;
      allowUnsupportedSystem = false;
      allowVariants = true;

      # showDerivationWarnings = [ "maintainerless" ];
    };

    overlays = [
      inputs.neru.overlays.default
      (final: prev: {
        neru = prev.neru.overrideAttrs (old: {
          doInstallCheck = false;
        });
      })
    ];
  };

  # assertions = [
  #   {
  #     assertion = pkgs.overlays == [ ];
  #     message = "nixpkgs overlays are not allowed in my config.";
  #   }
  # ];
}
