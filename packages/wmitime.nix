{ lib, stdenv, dockapps-sources, autoreconfHook, pkgconfig
, libX11
, libXpm
, libXext
, libdockapp }:

stdenv.mkDerivation rec {
  pname = "wmitime";
  version = "0.5";

  src = dockapps-sources;

  buildInputs = [ libX11 libXpm libXext libdockapp ];

  setSourceRoot = ''
    export sourceRoot=$(echo */${pname}/)
  '';

  postPatch = ''
    substituteInPlace Makefile \
      --replace "PREFIX = /usr/local" ""
  '';

  installFlags = [ "PREFIX=${placeholder "out"}" ];

  meta = with lib; {
    description = "Yet another clock dock app";
    homepage = "https://www.dockapps.net/wmitime";
    license = licenses.gpl2;
  };
}
