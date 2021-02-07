{ config, pkgs, callPackage, ... }:

{
  services.xserver = {
    desktopManager = {
      xterm.enable = false;
      xfce = {
        enable = true;
        noDesktop = true;
        enableXfwm = false;
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
        ];
      };
    };
    displayManager.defaultSession = "xfce+xmonad";
  };

  environment.systemPackages = with pkgs; [
    xmobar
    stalonetray
    xscreensaver
    dmenu
  ];
}
