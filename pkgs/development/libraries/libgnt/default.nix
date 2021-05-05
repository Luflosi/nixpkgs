{ stdenv, lib, fetchurl, meson, ninja, pkg-config, python2
, gtk-doc, docbook-xsl-nons
, glib, ncurses, libxml2
}:
let
  # Pidgin will get build-time dependency on gtk-doc anyway (through gstreamer).
  docs = true;
in
stdenv.mkDerivation rec {
  pname = "libgnt";
  version = "2.14.1";

  src = fetchurl {
    url = "mirror://sourceforge/pidgin/${pname}-${version}.tar.xz";
    sha256 = "sha256-XsPmjhj5VumZjXkIiymfo7ymibzJXIYAG8XaF8HrS9g=";
  };

  postPatch = ''
    substituteInPlace meson.build --replace \
      "ncurses_sys_prefix = '/usr'" \
      "ncurses_sys_prefix = '${lib.getDev ncurses}'"
  ''
  + lib.optionalString (!docs) ''
    sed "/^subdir('doc')$/d" -i meson.build
  '';

  outputs = [ "out" "dev" ] ++ lib.optional docs "devdoc";

  nativeBuildInputs = [ meson ninja pkg-config ]
   ++ lib.optionals docs [ gtk-doc docbook-xsl-nons ];

  # python2 is optional but Pidgin does depend on it (and python3 won't be accepted in 2.x)
  buildInputs = [ glib ncurses libxml2 python2 ];

  meta = with lib; {
    description = "An ncurses toolkit for creating text-mode graphical user interfaces";
    homepage = "https://keep.imfreedom.org/libgnt/libgnt/";
    license = licenses.gpl2Plus;
    platforms = platforms.unix;
  };
}
