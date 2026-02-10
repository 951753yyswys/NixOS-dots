{ config, pkgs, ... }:

{
  home-manager.users.Qaaxaap = { pkgs, ... }: {
    nixpkgs.config.allowUnfree = true;
    xdg.dataFile."applications/qq.desktop".text = ''
      [Desktop Entry]
      Name=QQ
      Exec=qq --ozone-platform=wayland --enable-wayland-ime --wayland-text-input-version=3 %U
      Terminal=false
      Type=Application
      Icon=${pkgs.qq}/share/icons/hicolor/512x512/apps/qq.png
      StartupWMClass=QQ
      Categories=Network;
      Comment=QQ
    '';
  };
}
