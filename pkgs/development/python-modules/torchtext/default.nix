{ lib
, buildPythonPackage
, fetchFromGitHub
, cmake
, which
, pybind11
, pytorch
, requests
, tqdm
, ninja
, python3
, pytestCheckHook
}:

buildPythonPackage rec {
  version = "0.11.2";
  pname = "torchtext";

  src = fetchFromGitHub {
    owner = "pytorch";
    repo = "text";
    rev = "v${version}";
    fetchSubmodules = true;
    hash = "sha256-Eysmm7tUFSa3bUAg/jS0k4gko8aP7Pws5Bjff7SpoBs=";
  };

  postPatch = ''
    substituteInPlace setup.py \
      --replace 'print(" --- Initializing submodules")' 'return'
  '';

  dontUseCmakeConfigure = true;

  nativeBuildInputs = [
    cmake
    #ninja
    which
    pybind11
  ];

  propagatedBuildInputs = [
    pytorch
    requests
    tqdm
  ];

  #environment.PYTHONPATH = "$out/${python3.sitePackages}/torchtext/";
  # {python}.sitePackages

  checkInputs = [
    pytestCheckHook
  ];

  pythonImportsCheck = [ "torchtext" ];
  postUnpack = ''
    # works
    #export PYTHONPATH=$out/lib/python3.11/site-packages/torchtext:$PYTHONPATH:$out/${python3.sitePackages}:$out/${python3.sitePackages}/torchtext

    export PYTHONPATH=$PYTHONPATH:$out/${python3.sitePackages}:$out/${python3.sitePackages}/torchtext
  '';

  doCheck = false;

  meta = with lib; {
    homepage = "https://pytorch.org/text/stable/index.html";
    description = "Models, data loaders and abstractions for language processing, powered by PyTorch";
    license = licenses.bsd3;
    maintainers = with maintainers; [ Luflosi ];
  };
}
