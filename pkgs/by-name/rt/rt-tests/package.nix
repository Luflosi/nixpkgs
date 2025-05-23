{
  stdenv,
  lib,
  makeWrapper,
  fetchurl,
  numactl,
  python3,
}:

stdenv.mkDerivation rec {
  pname = "rt-tests";
  version = "2.8";

  src = fetchurl {
    url = "https://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git/snapshot/${pname}-${version}.tar.gz";
    sha256 = "sha256-iBpd7K9VpvUH5wXBKypyQl8NAHN3Om5/PcoJ8RH37mI=";
  };

  nativeBuildInputs = [ makeWrapper ];
  buildInputs = [
    numactl
    python3
  ];

  makeFlags = [
    "prefix=$(out)"
    "DESTDIR="
    "PYLIB=$(out)/${python3.sitePackages}"
    "CC=${stdenv.cc.targetPrefix}cc"
    "AR=${stdenv.cc.bintools.targetPrefix}ar"
  ];

  postInstall = ''
    wrapProgram "$out/bin/determine_maximum_mpps.sh" --prefix PATH : $out/bin
  '';

  meta = with lib; {
    homepage = "https://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git";
    description = "Suite of real-time tests - cyclictest, hwlatdetect, pip_stress, pi_stress, pmqtest, ptsematest, rt-migrate-test, sendme, signaltest, sigwaittest, svsematest";
    platforms = platforms.linux;
    maintainers = with maintainers; [ poelzi ];
    license = licenses.gpl2Only;
  };
}
