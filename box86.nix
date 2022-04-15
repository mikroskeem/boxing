{ stdenv
, lib
, fetchFromGitHub
, cmake
, python3
}:

stdenv.mkDerivation rec {
  pname = "box86";
  version = "aa3474d06e173ad32301a394aed17499e0635843";

  src = fetchFromGitHub {
    owner = "ptitSeb";
    repo = pname;
    rev = version;
    sha256 = "sha256-hfjTKQoPnDQJPG7+Jnp4rmLz1Qt6dPfG8aw057JjIOs=";
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
    "-DCMAKE_C_COMPILER_TARGET=arm-linux-gnueabihf"
  ];
}
