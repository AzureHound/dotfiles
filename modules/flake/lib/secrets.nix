{ inputs, ... }:

let
  inherit (inputs) self;

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
in

{
  inherit mkSecret;
}
