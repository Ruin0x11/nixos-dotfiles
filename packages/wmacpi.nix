{ lib, stdenv, dockapps-sources
, libX11
, libXpm
, libXext
, libdockapp }:

stdenv.mkDerivation rec {
  pname = "wmacpi";
  version = "0.2.4";

  src = dockapps-sources;

  buildInputs = [ libX11 libXpm libXext libdockapp ];

  setSourceRoot = ''
    export sourceRoot=$(echo */${pname}/)
  '';

  installFlags = [ "PREFIX=${placeholder "out"}" ];

  meta = with lib; {
    description = "Dockapp ACPI battery monitor for modern kernels";
    homepage = "https://www.dockapps.net/cputnik";
    license = licenses.gpl2;
  };
}
