{ lib
, fetchFromGitHub
, python3Packages
}:

with python3Packages;
buildPythonApplication rec {
  pname = "boswatch3";
  version = "unstable-2023-01-24";
  format = "other";

  src = fetchFromGitHub {
    owner = "BOSWatch";
    repo = "BW3-Core";
    rev = "1b95474bc2ba1dd823c4ed985840f78a4ba88adc";
    sha256 = "sha256-qLL2TRI91C0/UrLl/QK2peqBik7ThfKSp/LZd4JpIpM=";
  };

  propagatedBuildInputs = [
    pyyaml
    mkdocs
  ];

  checkInputs = [
    pytestCheckHook
    pytest-cov
    #pytest-flake8
    pytest-flakes
    pytest-randomly
  ];

  dontConfigure = true;
  dontBuild = true;

  installPhase = ''
    runHook preInstall

    mkdir "$out"
    cp -r * "$out"

    runHook postInstall
  '';

  disabledTests = [
    # requires network access
    #"test_serverClientFetchConnInfo"
    #"test_clientWithoutServer"
  ];

  meta = with lib; {
    description = "Python Script to process input data from rtl_fm and multimon-NG";
    homepage = "https://docs.boswatch.de";
    license = licenses.gpl3Only;
    maintainers = with maintainers; [ Luflosi ];
  };
}

