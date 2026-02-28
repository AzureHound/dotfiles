{
  stdenv,
  lib,
  fetchurl,
  makeWrapper,
  chafa,
  curl,
  fzf,
  jq,
  mpv,
  socat,
}:

stdenv.mkDerivation rec {
  pname = "jelly";
  version = "3.5.0";

  src = fetchurl {
    url = "https://github.com/AzureHound/jelly/archive/refs/tags/v${version}.tar.gz";
    sha256 = "312e2ba5feec45ccf1b3b6aff89c58752271652ccc520965adf8181c752574f8";
  };

  nativeBuildInputs = [ makeWrapper ];

  installPhase = ''
    install -Dm755 src/jelly $out/bin/jelly

    wrapProgram $out/bin/jelly \
      --prefix PATH : ${
        lib.makeBinPath [
          chafa
          curl
          fzf
          jq
          mpv
          socat
        ]
      }
  '';
}
