{
  lib,
  stdenv,
  fetchFromGitHub,
  fetchpatch2,
  cmake,
  fuse3,
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

  patches = [
    (fetchpatch2 {
      name = "Enable fuse3 support.patch";
      # https://github.com/darlinghq/darling-dmg/pull/108
      url = "https://github.com/darlinghq/darling-dmg/commit/bce2b6fc76cd43446b41e6fb0cb2935721b49105.patch?full_index=1";
      hash = "sha256-j1qwXpUxtsshNfnk5uMccP+Xf8fuhcP2AeKhxzH6/Ts=";
    })
  ];

  nativeBuildInputs = [ cmake ];
  buildInputs = [
    fuse3
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
