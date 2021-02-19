{ config, pkgs, ... }:

let
  myXScreensaverConfig = {
    enable = true;
    settings = {
      mode = "blank";
      lock = true;
      fade = false;
      unfade = false;

      dpmsEnabled = true;
      dpmsQuickOff = true;
      dpmsStandby = "0:15:00";
      dpmsSuspend = "0:30:00";
      dpmsOff = "1:00:00";
    };
    #dateFormat = "%Y-%m-%d %H:%M";
    #Dialog = {
    #  background = "#000000";
    #  borderWidth = 0;
    #  bottomShadowColor = "#000000";
    #  Button = {
    #    background = "#222222";
    #    foreground = "#eeeeee";
    #  };
    #  foreground = "#dddddd";
    #  text = {
    #    background = "#222222";
    #    foreground = "#eeeeee";
    #  };
    #  topShadowColor = "#000000";
    #  internalBorderWidth = 24;
    #  shadowThickness = 2;
    #};
    #passwd.thermometer = {
    #  background = "#000000";
    #  foreground = "#ff0000";
    #};
    #splash = false;
  };
in
{
  #home-manager.users = {
  #  root = {
  #    services.xscreensaver = myXScreensaverConfig;
  #  };

  #  savau = {
  #    services.xscreensaver = myXScreensaverConfig;
  #  };
  #};

  environment.systemPackages = with pkgs; [
    xscreensaver
  ];
}
