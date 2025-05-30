{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  setuptools,
  pkgs,
  qtbase,
  qmake,
  soqt,
}:

buildPythonPackage rec {
  pname = "pivy";
  version = "0.6.10";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "coin3d";
    repo = "pivy";
    tag = version;
    hash = "sha256-DRA4NTAHg2iB/D1CU9pJEpsZwX9GW3X5gpxbIwP54Ko=";
  };

  build-system = [ setuptools ];

  dontUseCmakeConfigure = true;

  nativeBuildInputs = with pkgs; [
    swig
    qmake
    cmake
  ];

  buildInputs =
    with pkgs;
    with xorg;
    [
      coin3d
      soqt
      qtbase
      libGLU
      libGL
      libXi
      libXext
      libSM
      libICE
      libX11
    ];

  env.NIX_CFLAGS_COMPILE = toString [
    "-I${qtbase.dev}/include/QtCore"
    "-I${qtbase.dev}/include/QtGui"
    "-I${qtbase.dev}/include/QtOpenGL"
    "-I${qtbase.dev}/include/QtWidgets"
  ];

  dontUseQmakeConfigure = true;
  dontWrapQtApps = true;
  doCheck = false;

  postPatch = ''
    substituteInPlace distutils_cmake/CMakeLists.txt --replace \$'{SoQt_INCLUDE_DIRS}' \
      \$'{Coin_INCLUDE_DIR}'\;\$'{SoQt_INCLUDE_DIRS}'
  '';

  pythonImportsCheck = [ "pivy" ];

  meta = with lib; {
    homepage = "https://github.com/coin3d/pivy/";
    description = "Python binding for Coin";
    license = licenses.bsd0;
    maintainers = with maintainers; [ ];
  };
}
