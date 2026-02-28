{
  stdenv,
  fetchurl,
}:

stdenv.mkDerivation {
  name = "banana-cursor";
  version = "2.1.0";

  src = fetchurl {
    url = "https://github.com/AzureHound/banana-cursor/releases/download/v2.1.0/banana-all.tar.xz";
    sha256 = "sha256-kD0WxXcHqWBzmkHJpbgL4YhC+hf/EC6tRwwYVAlHvW0=";
  };

  dontUnpack = true;

  installPhase = ''
    mkdir -p $out/share/icons
    tar xvf $src -C $out/share/icons
  '';
}
