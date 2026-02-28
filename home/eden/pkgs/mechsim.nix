{
  stdenv,
  fetchFromGitHub,
  pkg-config,
  json_c,
  libpulseaudio,
  libsndfile,
  libinput,
  libevdev,
  systemd,
}:

stdenv.mkDerivation rec {
  pname = "mechsim";
  version = "1.1.0";

  src = fetchFromGitHub {
    owner = "cjlangan";
    repo = "MechSim";
    rev = "v${version}";
    sha256 = "sha256-Ppc8LzKu7LabJck7f2CnycbTmp9t/In0ADBW0ZMjOAY=";
  };

  nativeBuildInputs = [ pkg-config ];

  buildInputs = [
    json_c
    libpulseaudio
    libsndfile
    libinput
    libevdev
    systemd
  ];

  postPatch = ''
    substituteInPlace mechsim.c \
      --replace 'snprintf(sudo_path, sizeof(sudo_path), "%s/bin/sudo", PACKAGE_PREFIX);' \
                'snprintf(sudo_path, sizeof(sudo_path), "/run/wrappers/bin/sudo");'

    substituteInPlace mechsim.c \
      --replace 'execl(sudo_path, "sudo", "-n", get_key_presses_path, (char *)NULL);' \
                'execl(sudo_path, "sudo", "--preserve-env=PATH", "-n", get_key_presses_path, (char *)NULL);'
  '';

  makeFlags = [ "PREFIX=${placeholder "out"}" ];

  installPhase = ''
    runHook preInstall
    make install PREFIX=$out
    runHook postInstall
  '';
}
