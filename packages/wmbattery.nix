{ lib, stdenv, dockapps-sources, autoreconfHook, pkgconfig
, libX11
, libXpm
, libXext
, upower
, libdockapp }:

stdenv.mkDerivation rec {
  pname = "wmbattery";
  version = "2.54";

  src = dockapps-sources;

  nativeBuildInputs = [ autoreconfHook pkgconfig ];
  buildInputs = [ libX11 libXpm libXext libdockapp upower ];

  setSourceRoot = ''
    export sourceRoot=$(echo */${pname}/)
  '';

  configurePhase = ''
    ./configure --prefix=$out
  '';

  meta = with lib; {
    description = "Battery monitor for WindowMaker";
    homepage = "https://www.dockapps.net/wmbattery";
    license = licenses.gpl2;
  };
}
