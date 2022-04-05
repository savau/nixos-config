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
          haskellPackages.xmonad
          haskellPackages.xmonad-contrib
          haskellPackages.xmonad-extras
          haskellPackages.dbus  # needed for integration with xfce4-panel
          haskellPackages.tuple
        ];
      };
    };
    displayManager.defaultSession = "xfce+xmonad";
  };

  environment.systemPackages = with pkgs; [
    # status bar
    #xmobar

    # system tray
    #stalonetray

    # system tray stuff
    birdtray
    volumeicon

    # dynamic menu
    dmenu

    autoconf automake pkg-config  # needed for xmonad integration with xfce4-panel

    # file manager
    xfce.thunar

    # xfce4-panel to allow manual launch if needed
    xfce.xfce4-panel
  ];
}
