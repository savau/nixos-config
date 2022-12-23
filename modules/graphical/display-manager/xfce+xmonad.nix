{ config, pkgs, ... }:

{
  services.xserver = {
    desktopManager = {
      xterm.enable = false;
      xfce = {
        enable = true;
        noDesktop = true;
        enableXfwm = false;
        enableScreensaver = false;
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
          haskellPackages.dbus
          haskellPackages.status-notifier-item
          haskellPackages.gtk-sni-tray
          haskellPackages.tuple
        ];
      };
    };
    displayManager.defaultSession = "xfce+xmonad";
  };

  programs.thunar.plugins = with pkgs.xfce; [
    thunar-archive-plugin
    thunar-volman
  ];

  environment.systemPackages = with pkgs; [
    # status bar
    taffybar

    # dynamic menu
    dmenu

    autoconf automake pkg-config  # needed for xmonad integration with xfce4-panel

    # file manager
    xfce.thunar

    # xfce4-panel to allow manual launch if needed
    xfce.xfce4-panel
  ];
}
