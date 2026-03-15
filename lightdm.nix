{ pkgs, ... }:
let
  wallpaper = pkgs.runCommand "login-wallpaper" {} ''
    cp ${./wallpaper.png} $out
  '';
in
{
  services.xserver.enable = true;
  services.xserver.displayManager.lightdm = {
    enable = true;
    greeters.gtk = {
      enable = true;
      theme = {
        name = "Breeze";
        package = pkgs.kdePackages.breeze-gtk;
      };
      iconTheme = {
        name = "breeze";
        package = pkgs.kdePackages.breeze-icons;
      };
      cursorTheme = {
        name = "breeze_cursors";
        size = 24;
      };
      extraConfig = ''
        background = ${wallpaper}
        user-background = false
        hide-user-image = false
        position = 50%,center
        indicators = ~session;~host;~clock;~power
      '';
    };
  };
  security.pam.services.lightdm.fprintAuth = true;
  environment.systemPackages = with pkgs.kdePackages; [
    breeze-gtk
    breeze-icons
  ];
  services.gvfs.enable = true;
  programs.dconf.enable = true;
  xdg.portal = {
    enable = true;
    config.common.default = "kde";
    extraPortals = [
      pkgs.kdePackages.xdg-desktop-portal-kde
    ];
    xdgOpenUsePortal = true;
  };
  services.xserver.desktopManager.runXdgAutostartIfNone = true;
  environment.etc."kdeglobals".text = ''
    [InputMethod]
    ${pkgs.fcitx5}/share/applications/org.fcitx.Fcitx5.desktop
  '';
  systemd.user.units."app-org.fcitx.Fcitx5@autostart.service".enable = false;
}
