{ lib, inputs, ... }:

let
  inherit (inputs) self;
  inherit (lib.attrsets) mapAttrs;
  inherit (lib.modules) mkOptionDefault;
  inherit (lib.strings) concatStringsSep;

  mkService = name: defaults: {
    pixel.services.${name} = mapAttrs (_: mkOptionDefault) defaults;
  };

  mkSecret =
    {
      file,
      ...
    }@args:
    let
      args' = removeAttrs args [ "file" ];
    in
    {
      sopsFile = "${self}/secrets/services/${file}.yaml";
    }
    // args';

  web = {
    port = "http,https";
    protocol = "tcp,udp";
  };

  journalJail = unit: regexes: settings: {
    filter.Definition = {
      failregex = concatStringsSep "\n    " regexes;
      ignoreregex = "";
    };
    settings = web // { journalmatch = "_SYSTEMD_UNIT=${unit}.service"; } // settings;
  };
in

{
  inherit
    mkService
    mkSecret
    web
    journalJail
    ;
}
