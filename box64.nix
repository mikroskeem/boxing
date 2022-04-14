{ stdenv
, lib
, fetchFromGitHub
, cmake
, python3
, with16KPage ? false
}:

stdenv.mkDerivation rec {
  pname = "box64";
  version = "0.1.6";

  src = fetchFromGitHub {
    owner = "ptitSeb";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-z7tOTQ1knpCKmpCB7rAU4bhCq5qWr2o4luhGy2AMohY=";
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
