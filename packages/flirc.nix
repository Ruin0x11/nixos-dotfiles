 { stdenv, lib
, dpkg
, fetchurl
, libusb
, hidapi
, readline6
, libsForQt5
, autoPatchelfHook
, wrapQtAppsHook  
}:

stdenv.mkDerivation rec {
  name = "flirc-${version}";

  version = "3.25.3";

  src = fetchurl {
    url = "https://apt.fury.io/flirc/flirc-${version}-amd64";
    sha256 = "14j1nqmb7jz1njk7rid7hfnk2bd92ql3l5b58g55vx7z0n3445f3";
  };

  nativeBuildInputs = [
    autoPatchelfHook wrapQtAppsHook  
  ];

  buildInputs = [
    libusb
    hidapi
    libsForQt5.qt5.qtsvg
    libsForQt5.qt5.qtxmlpatterns
    readline6
  ];

  sourceRoot = ".";

  unpackCmd = "${dpkg}/bin/dpkg-deb -x $curSrc .";
  installPhase = ''
    mkdir -p $out
    cp -r ./usr/* $out
	rm -r ./usr
    cp -r . $out
  '';

  meta = with lib; {
    homepage = "https://flirc.tv";
    description = "Flirc IR receiver control";
    platforms = platforms.linux;
  };
}
