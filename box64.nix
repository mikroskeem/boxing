{ stdenv
, lib
, fetchFromGitHub
, cmake
, python3
, with16KPage ? false
}:

stdenv.mkDerivation rec {
  pname = "box64";
  version = "34f7571269581bd9393f30eeaab3f46d59cb30dd";

  src = fetchFromGitHub {
    owner = "ptitSeb";
    repo = pname;
    rev = version;
    sha256 = "sha256-UUXhuDVHHK1kcP1Y1yqCT0m4xbEbxtJbKnYBasJ3OQw=";
  };

  nativeBuildInputs = [
    cmake
    python3
  ];

  postPatch = ''
    substituteInPlace CMakeLists.txt \
      --replace 'DESTINATION /' 'DESTINATION ${placeholder "out"}/'
  '';

  cmakeFlags = [
    "-DNOGIT=ON"
    "-DARM_DYNAREC=ON"
  ] ++ lib.optionals with16KPage [
    "-DM1=1"
  ];
}
