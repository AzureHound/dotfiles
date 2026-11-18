{ lib }:

let
  inherit (lib.strings) concatStringsSep;

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
  inherit web journalJail;
}
