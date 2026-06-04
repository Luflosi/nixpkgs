{
  lib,
  stdenv,
  fetchFromGitHub,
  cmake,
  fuse,
  zlib,
  bzip2,
  openssl,
  libxml2,
  icu,
  lzfse,
  libiconv,
  nixosTests,
}:

stdenv.mkDerivation {
  pname = "darling-dmg";
  version = "1.0.4-unstable-2025-10-18";

  src = fetchFromGitHub {
    owner = "darlinghq";
    repo = "darling-dmg";
    rev = "1a6de10c5886c40a414090701b2520bd0417ce29";
    hash = "sha256-8jk8018S8U0aaNiUoAiYy06Uk28+BaJDS+dpeLJDpAM=";
  };

  nativeBuildInputs = [ cmake ];
  buildInputs = [
    fuse
    openssl
    zlib
    bzip2
    libxml2
    icu
    lzfse
  ]
  ++ lib.optionals stdenv.hostPlatform.isDarwin [ libiconv ];

  env.CXXFLAGS = toString [
    "-DCOMPILE_WITH_LZFSE=1"
    "-llzfse"
  ];

  passthru.tests = {
    inherit (nixosTests) darling-dmg;
  };

  meta = {
    homepage = "https://www.darlinghq.org/";
    description = "FUSE module for .dmg files (containing an HFS+ filesystem)";
    mainProgram = "darling-dmg";
    platforms = lib.platforms.unix;
    license = lib.licenses.gpl3Only;
    maintainers = with lib.maintainers; [ Luflosi ];
  };
}
