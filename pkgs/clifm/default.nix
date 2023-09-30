{ stdenv, lib, fetchFromGitHub, libcap, acl, file, readline }:

stdenv.mkDerivation rec {
  pname = "clifm";
  version = "1.14.6";

  src = fetchFromGitHub {
    owner = "leo-arch";
    repo = pname;
    rev = "v${version}";
    sha256 = "15qrgj4kzxkc4lp3rpqvyk9ilc4nckrpiskg7y7p6bqr23n8chyh";
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
    maintainers = with maintainers; [ ];
    platforms = platforms.unix;
  };
}
