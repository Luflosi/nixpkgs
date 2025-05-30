{
  lib,
  stdenv,
  fetchurl,
  e2fsprogs,
  openldap,
  pkg-config,
  binlore,
  linuxquota,
}:

stdenv.mkDerivation rec {
  version = "4.10";
  pname = "quota";

  src = fetchurl {
    url = "mirror://sourceforge/linuxquota/quota-${version}.tar.gz";
    sha256 = "sha256-oEoMr8opwVvotqxmDgYYi8y4AsGe/i58Ge1/PWZ+z14=";
  };

  outputs = [
    "out"
    "dev"
    "doc"
    "man"
  ];

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [
    e2fsprogs
    openldap
  ];

  passthru.binlore.out = binlore.synthesize linuxquota ''
    execer cannot bin/quota
  '';

  meta = with lib; {
    description = "Tools to manage kernel-level quotas in Linux";
    homepage = "https://sourceforge.net/projects/linuxquota/";
    license = licenses.gpl2Plus; # With some files being BSD as an exception
    platforms = platforms.linux;
    maintainers = [ maintainers.dezgeg ];
  };
}
