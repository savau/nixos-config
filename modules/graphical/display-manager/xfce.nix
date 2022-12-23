{ config, pkgs, ... }:

{
  services.xserver = {
    desktopManager = {
      xterm.enable = false;
      xfce = {
        enable = true;
        noDesktop = false;
        enableXfwm = true;
        enableScreensaver = true; # TODO Just trying it out, but I probably don't want this
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
          #newHaskellPackages.taffybar
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
    # system tray stuff
    #birdtray
    #volumeicon

    # dynamic menu
    #dmenu

    # file manager
    #xfce.thunar
  ];
}
