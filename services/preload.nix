{
  lib,
  stdenv,
  fetchurl,
  pkg-config,
  glib,
  libelf,
  readline,
  zlib,
}:

stdenv.mkDerivation rec {
  pname = "preload";
  version = "0.6.4";

  src = fetchurl {
    url = "https://downloads.sourceforge.net/project/preload/preload/${version}/preload-${version}.tar.gz";
    sha256 = "0sw15yi8q12ab7n1mbc9lm1mxrdlyhwyydk7v7cm36mj7kl5i9fh";
  };

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [
    glib
    libelf
    readline
    zlib
  ];

  configureFlags = [
    "--prefix=${placeholder "out"}"
    "--sysconfdir=${placeholder "out"}/etc"
    "--localstatedir=/var"
  ];

  installFlags = [ "localstatedir=${placeholder "out"}/var" ];

  # Ajuste se o build falhar; isso é um esqueleto básico.
  meta = with lib; {
    description = "Adaptive readahead daemon";
    homepage = "https://sourceforge.net/projects/preload/";
    license = licenses.gpl2Plus;
    platforms = platforms.linux;
    maintainers = [ ];
  };
}
