{ lib, ... }:

let
  giturl =
    {
      domain,
      alias,
      user ? "git",
      port ? null,
      ...
    }:
    {
      "https://${domain}/".insteadOf = "${alias}:";
      "ssh://${user}@${domain}${
        if (port == null) then
          ""
        else if (builtins.isInt port) then
          ":" + (toString port)
        else
          ":" + port
      }/".pushInsteadOf =
        "${alias}:";
    };

  mkPub = host: key: {
    "${host}-${key.type}" = {
      hostNames = [ host ];
      publicKey = "ssh-${key.type} ${key.key}";
    };
  };

  mkPubs = host: keys: lib.attrsets.mergeAttrsList (map (mkPub host) keys);
in

{
  inherit
    giturl
    mkPub
    mkPubs
    ;
}
