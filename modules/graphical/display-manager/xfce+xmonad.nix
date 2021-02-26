{ config, pkgs, ... }:

{
  services.xserver = {
    desktopManager = {
      xterm.enable = false;
      xfce = {
        enable = true;
        noDesktop = true;
        enableXfwm = false;
        thunarPlugins = with pkgs.xfce; [
          thunar-archive-plugin
          thunar-volman
        ];
      };
    };
    windowManager = {
      xmonad = {
        enable = true;
        enableContribAndExtras = true;
        extraPackages = haskellPackages : [
          haskellPackages.xmonad-contrib
          haskellPackages.xmonad-extras
          haskellPackages.xmonad
          #haskellPackages.dbus  # needed for xmonad integration with xfce4-panel
        ];
      };
    };
    displayManager.defaultSession = "xfce+xmonad";
  };

  environment.systemPackages = with pkgs; [
    # status bar
    xmobar

    # system tray
    stalonetray

    # system tray stuff
    birdtray
    volumeicon

    # dynamic menu
    dmenu

    #autoconf automake pkg-config  # needed for xmonad integration with xfce4-panel

    # file manager
    xfce.thunar
  ];
}
