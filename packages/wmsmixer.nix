{ lib, stdenv, dockapps-sources
, imake
, gccmakedep
, gcc_multi
, libX11
, libXpm
, libXext }:

stdenv.mkDerivation rec {
  pname = "wmsmixer";
  version = "0.5.1";

  src = dockapps-sources;

  nativeBuildInputs = [ imake gccmakedep ];

  buildInputs = [ libX11 libXpm libXext gcc_multi ];

  preBuild = ''
    xmkmf
  '';

  setSourceRoot = ''
    export sourceRoot=$(echo */${pname}/)
  '';

  installPhase = ''
    runHook preInstall
    mkdir -p $out/bin
    cp ./wmsmixer $out/bin
    runHook postInstall
  '';

  meta = with lib; {
    description = "Audio mixer for WindowMaker";
    homepage = "https://www.dockapps.net/wmsmapp";
    license = licenses.gpl2;
  };
}
