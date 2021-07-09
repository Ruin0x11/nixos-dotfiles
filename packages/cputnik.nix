{ lib, stdenv, dockapps-sources
, libX11
, libXpm
, libXext
, libdockapp }:

stdenv.mkDerivation rec {
  pname = "cputnik";
  version = "0.2.0";

  src = dockapps-sources;

  buildInputs = [ libX11 libXpm libXext libdockapp ];

  setSourceRoot = ''
    export sourceRoot=$(echo */${pname}/src)
  '';

  postPatch = ''
    substituteInPlace Makefile \
      --replace "INSTALL_PREFIX	= /usr/local" ""
  '';

  hardeningDisable = [ "format" ];

  makeFlags = [ "CC=${stdenv.cc.targetPrefix}cc" ];

  installPhase = ''
    runHook preInstall
    mkdir -p $out/bin
    cp ./cputnik $out/bin
    runHook postInstall
  '';

  installFlags = [ "INSTALL_PREFIX=${placeholder "out"}/bin" ];

  meta = with lib; {
    description = "A simple CPU and memory monitor.";
    homepage = "https://www.dockapps.net/cputnik";
    license = licenses.gpl2;
  };
}

