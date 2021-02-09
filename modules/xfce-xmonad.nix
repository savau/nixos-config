{ config, pkgs, callPackage, ... }:

{
  services.xserver = {
    desktopManager = {
      xterm.enable = false;
      xfce = {
        enable = true;
        noDesktop = false;
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
          haskellPackages.dbus  # needed for integration with xfce4-panel
        ];
      };
    };
    displayManager.defaultSession = "xfce+xmonad";
  };

  environment.systemPackages = with pkgs; [
    xscreensaver
    #xmobar
    #stalonetray
    dmenu
  ];
}
