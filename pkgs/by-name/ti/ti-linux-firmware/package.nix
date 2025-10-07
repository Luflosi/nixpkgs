{
  stdenvNoCC,
  fetchgit,
  lib,
  linux-firmware,
  python3,
  rdfind,
  which,
}:
stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "ti-linux-firmware";
  version = "11.01.14";

  src = fetchgit {
    url = "git://git.ti.com/processor-firmware/ti-linux-firmware.git";
    tag = finalAttrs.version;
    hash = "sha256-f/DvsgbjG/QTS9QW0bVVKdordZshU9pMkp7PtLz1bws=";
  };

  # postUnpack = ''
  #   patchShebangs .
  # '';

  nativeBuildInputs = [
    linux-firmware.gitStub
    # python3
    # rdfind
    # which
  ];

  makeFlags = [ "DESTDIR=$(out)" ];

  # Firmware blobs do not need fixing and should not be modified
  dontFixup = true;

  meta = {
    description = "Binary firmware collection for Texas Instruments";
    # There is not really a homepage.
    # The README has not even been changed after forking the repo from Linux.
    license = lib.licenses.unfreeRedistributableFirmware;
    platforms = lib.platforms.linux;
    maintainers = with lib.maintainers; [
      Luflosi
    ];
  };
})
