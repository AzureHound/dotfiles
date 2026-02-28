{
  stdenv,
  fetchFromGitLab,
  ncurses,
  pkg-config,
  nix-update-script,
}:

stdenv.mkDerivation rec {
  pname = "cbonsai";
  version = "1.4.2";

  src = fetchFromGitLab {
    owner = "jallbrit";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-TZb/5DBdWcl54GoZXxz2xYy9dXq5lmJQsOA3C26tjEU=";
  };

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [ ncurses ];
  installFlags = [ "PREFIX=$(out)" ];

  passthru.updateScript = nix-update-script { attrPath = pname; };
}
