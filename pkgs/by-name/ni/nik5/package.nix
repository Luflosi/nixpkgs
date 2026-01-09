{
  lib,
  stdenv,
  nixosTests,
  fetchFromGitea,
  cmake,
  pkg-config,
  mapnik,
  cairo,
  boost,
  expat,
  libxdmcp,
  icu,
  harfbuzz,
  libxml2,
  libjpeg,
  libtiff,
  libwebp,
  proj,
  libsysprof-capture,
  pcre2,
}:

stdenv.mkDerivation {
  pname = "nik5";
  version = "0-unstable-2025-12-29";

  src = fetchFromGitea {
    domain = "codeberg.org";
    owner = "Geofabrik";
    repo = "Nik5";
    rev = "0bb20a2bfde429f85f646d6f24c630ed835133aa1af7da4a6db4fa43b31c7455";
    hash = "sha256-ZytBcRga+a0BQXGCCs0Q1RkQp8Rr1qiiFjIPEhXvhGs=";
  };

  # postPatch = ''
  #   substituteInPlace tests/include/utils.hpp --replace-fail \
  #     '#include <mapnik/box2d.hpp>' \
  #     '#include <mapnik/geometry/box2d.hpp>'
  # '';

  nativeBuildInputs = [
    cmake
    pkg-config
    # mapnik
    # boost
  ];

  buildInputs = [
    mapnik
    # cairo
    expat
    # boost
    # TODO: figure out, why we need to add the dependencies of mapnik here
    libxdmcp
    # icu
    # harfbuzz
    # libxml2
    # libjpeg
    # libtiff
    # libwebp
    # proj
    libsysprof-capture
    pcre2.dev
  ] ++ mapnik.buildInputs ++ libtiff.buildInputs;

  # nativeCheckInputs = [
  #   mapnik
  # ];
  # checkInputs = [
  #   mapnik
  # ];
  # propagatedBuildInputs = [
  #   mapnik
  # ];

  cmakeFlags = [
    (lib.cmakeBool "BUILD_TESTS" false)
  ];

  passthru.tests = {
    inherit (nixosTests) nik5;
  };

  strictDeps = true;

  meta = {
    description = "Mapnik to image export, C++ port of https://github.com/Zverik/Nik4";
    homepage = "https://codeberg.org/Geofabrik/Nik5";
    license = lib.licenses.wtfpl;
    maintainers = with lib.maintainers; [
      Luflosi
    ];
    mainProgram = "nik5";
    platforms = lib.platforms.linux;
  };
}
