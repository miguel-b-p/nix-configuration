{
  lib,
  stdenv,
  fetchzip,
  autoconf,
  automake,
  pkg-config,
  glib,
  preload-ng-src,
}:

stdenv.mkDerivation rec {
  pname = "preload-ng";
  version = "0.6.6";

  src = preload-ng-src;
  patches = [
    ./0001-prevent-building-to-var-directories.patch
  ];

  nativeBuildInputs = [
    autoconf
    automake
    pkg-config
  ];
  buildInputs = [ glib ];

  configureFlags = [ "--localstatedir=/var" ];

  postInstall = ''
    make sysconfigdir=$out/etc/conf.d install
  '';

  meta = with lib; {
    description = "Makes applications run faster by prefetching binaries and shared objects";
    homepage = "https://sourceforge.net/projects/preload";
    license = licenses.gpl2Only;
    platforms = lib.platforms.linux;
    mainProgram = "preload";
    maintainers = with maintainers; [ ldprg ];
  };
}
