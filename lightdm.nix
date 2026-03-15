{ config, pkgs, ... }:
let
  wallpaper = pkgs.runCommand "login-wallpaper" {} ''
    cp ${./wallpaper.png} $out
  '';
in
{
  services.xserver.enable = true;

  services.xserver.displayManager.lightdm = {
    enable = true;
    greeters.pantheon.enable = true;
  };

  # 通过 dconf 设置 pantheon greeter 的背景壁纸
  programs.dconf = {
    enable = true;
    profiles.lightdm = {
      databases = [{
        settings = {
          "org/gnome/desktop/background" = {
            picture-uri = "file://${wallpaper}";
            picture-options = "zoom";
          };
        };
      }];
    };
  };

  # ========== 以下是你原有的全部配置，保持不变 ==========
  security.pam.services.lightdm.fprintAuth = true;
  services.gvfs.enable = true;
  xdg.portal = {
    enable = true;
    config.common.default = "kde";
    extraPortals = [ pkgs.kdePackages.xdg-desktop-portal-kde ];
    xdgOpenUsePortal = true;
  };
  services.xserver.desktopManager.runXdgAutostartIfNone = true;
  environment.etc."kdeglobals".text = ''
    [InputMethod]
    ${pkgs.fcitx5}/share/applications/org.fcitx.Fcitx5.desktop
  '';
  systemd.user.units."app-org.fcitx.Fcitx5@autostart.service".enable = false;
}
