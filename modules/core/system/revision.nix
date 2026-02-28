{
  lib,
  self,
  _class,
  config,
  ...
}:

let
  inherit (lib.options) mkOption;

  cfg = config.pixel.system;
in

{
  options.pixel.system.stateVersion = mkOption {
    internal = true;
    type = lib.types.str;
    default = "26.05";
  };

  config.system = {
    # https://nixos.org/manual/nixos/unstable/release-notes.html
    stateVersion = if (_class == "nixos") then cfg.stateVersion else 6;

    # `nixos-version --revision`
    configurationRevision = self.shortRev or self.dirtyShortRev or "dirty";
  };
}
