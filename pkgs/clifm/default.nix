{ stdenv, lib, fetchFromGitHub, libcap, acl, file, readline }:

stdenv.mkDerivation rec {
  pname = "clifm";
  version = "1.15";

  src = fetchFromGitHub {
    owner = "leo-arch";
    repo = pname;
    rev = "v${version}";
    sha256 = "1r9pxlyn8jg0wmzbmbc71l42098lz5k32k6yid09yz6d0gaax7g1";
  };

  buildInputs = [ libcap acl file readline ];

  makeFlags = [
    "DESTDIR=${placeholder "out"}"
    "DATADIR=/share"
    "PREFIX=/"
  ];

  enableParallelBuilding = true;

  meta = with lib; {
    homepage = "https://github.com/leo-arch/clifm";
    description = "CliFM is a CLI-based, shell-like, and non-curses terminal file manager written in C: simple, fast, extensible, and lightweight as hell";
    license = licenses.gpl2Plus;
    # maintainers = with maintainers; [ ];
    platforms = platforms.unix;
  };
}
