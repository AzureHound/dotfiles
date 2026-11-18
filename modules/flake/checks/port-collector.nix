{
  lib,
  runCommandLocal,
  self,
}:

let
  inherit (lib.attrsets)
    attrNames
    attrValues
    filterAttrs
    mapAttrsToList
    ;
  inherit (lib.lists)
    concatLists
    concatMap
    filter
    groupBy
    length
    ;
  inherit (lib.strings) concatStringsSep hasSuffix;

  isPort = name: value: (name == "port" || hasSuffix "Port" name) && builtins.isInt value;

  # [ { port = "3000"; owner = "pds.port"; } ... ]
  portsOf =
    services:
    concatMap (
      service:
      mapAttrsToList (option: port: {
        port = toString port;
        owner = "${service}.${option}";
      }) (filterAttrs isPort services.${service})
    ) (attrNames services);

  collisionsOn =
    host: nixos:
    map (owners: "${host}: ${concatStringsSep " and " owners}") (
      filter (owners: length owners > 1) (
        attrValues (builtins.mapAttrs (_: map (p: p.owner)) (groupBy (p: p.port) (portsOf nixos.config.pixel.services)))
      )
    );

  hosts = filterAttrs (_: nixos: nixos.config ? pixel) self.nixosConfigurations;

  collisions = concatLists (mapAttrsToList collisionsOn hosts);
in

runCommandLocal "port-collector"
  {
    __structuredAttrs = true;
  }
  ''
    if [ ${toString (collisions != [ ])} ]; then
      echo "Port collisions detected between ${concatStringsSep ", " collisions}"
      exit 1
    fi

    touch $out
  ''
