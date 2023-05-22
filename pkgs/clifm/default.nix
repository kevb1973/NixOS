{ stdenv, lib, fetchFromGitHub, libcap, acl, file, readline }:

stdenv.mkDerivation rec {
  pname = "clifm";
  version = "1.12";

  src = fetchFromGitHub {
    owner = "leo-arch";
    repo = pname;
    rev = "v${version}";
    sha256 = "0dfzajj27lfp1zfz3c7j2kkvlc1q9i94qjvbshl8nk79xsgbvzjg";
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
