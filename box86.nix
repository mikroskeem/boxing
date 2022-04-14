{ stdenv
, lib
, fetchFromGitHub
, cmake
, python3
}:

stdenv.mkDerivation rec {
  pname = "box86";
  version = "0.2.4";

  src = fetchFromGitHub {
    owner = "ptitSeb";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-ZMTn8x6PVLMHQYtqA+Eh0xISQKlKg5THRuxcY3rCx8g=";
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
    "-DARM_DYNAREC=ON"
    "-DCMAKE_C_COMPILER_TARGET=arm-linux-gnueabihf"
  ];
}
