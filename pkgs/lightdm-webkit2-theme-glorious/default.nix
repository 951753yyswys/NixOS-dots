{ lib, stdenv, fetchzip }:

stdenv.mkDerivation rec {
  pname = "lightdm-webkit2-theme-glorious";
  version = "ab3d6fa";

  src = fetchzip {
    url = "https://github.com/manilarome/lightdm-webkit2-theme-glorious/archive/${version}.tar.gz";
    hash = "sha256-mjjNt9of34plE3DVAPS2T76Yj9WbFDAXVVb7mjvC0tY=";  # 填入获取的 hash
  };

  installPhase = ''
    mkdir -p $out/share/lightdm-webkit/themes/glorious
    cp -r * $out/share/lightdm-webkit/themes/glorious/
  '';

  meta = with lib; {
    description = "Glorious lightdm-webkit2 theme";
    homepage = "https://github.com/manilarome/lightdm-webkit2-theme-glorious";
    license = licenses.mit;
    platforms = platforms.all;
  };
}
