{ lib, stdenv, fetchurl, dpkg }:

stdenv.mkDerivation rec {
  pname = "nody-greeter";
  version = "1.6.2";

  src = fetchurl {
    url = "https://github.com/JezerM/nody-greeter/releases/download/${version}/nody-greeter-${version}-ubuntu.deb";
    hash = "sha256-O4spN/pCo2zM5ZY2P4JlD+ZNSJGsIjdNM6im3NRCkNI="; 
  };

  nativeBuildInputs = [ dpkg ];

  unpackPhase = ''
    dpkg-deb -x $src .
  '';

  installPhase = ''
    mkdir -p $out
    cp -r . $out/
  '';

  meta = with lib; {
    description = "LightDM greeter made with web technologies (prebuilt from Ubuntu .deb)";
    homepage = "https://github.com/JezerM/nody-greeter";
    license = licenses.gpl3;
    platforms = platforms.linux;
  };
}
