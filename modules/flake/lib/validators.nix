{ lib, ... }:

let
  inherit (lib.attrsets) getAttrFromPath;
  inherit (lib.lists) any;

  anyHome =
    conf: cond:
    let
      list = map (
        user:
        getAttrFromPath [
          "home-manager"
          "users"
          user
        ] conf
      ) conf.pixel.system.users;
    in
    any cond list;
in

{
  inherit anyHome;
}
