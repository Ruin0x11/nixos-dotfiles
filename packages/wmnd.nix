{ lib, stdenv, dockapps-sources
, libX11
, libXpm
, libXext
, fetchurl }:

let
  version = "0.4.18";
  src = fetchurl {
    urls = [
      "https://www.thregr.org/~wavexx/software/wmnd/releases/wmnd-${version}.tar.gz"
    ];
    sha256 = "01s37d8cfpncza1mlw13ar4rcwbrc1vgaj3ifhglmlcnzvvayg0n";
  };
in stdenv.mkDerivation rec {
  pname = "wmnd";
  inherit version;

  srcs = [ src ];

  buildInputs = [ libX11 libXpm libXext ];

  installPhase = ''
    runHook preInstall
    install -Dm555 -t $out/bin src/wmnd
    runHook postInstall
  '';

  meta = with lib; {
    description = "Network monitoring app for WindowMaker";
    license = licenses.gpl2;
    homepage = "https://thregr.org/~wavexx/software/wmnd/";
    platforms = [ "x86_64-linux" ];
  };
}
