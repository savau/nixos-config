{ config, pkgs, lib, machine, ... }:

with lib;

let
  myXScreenSaverConfig = {
    services.xscreensaver = {
      enable = true;

      settings = {
        mode = "blank";
        lock = true;
        fade = false;
        unfade = false;
        splash = false;
        dateFormat = "%Y-%m-%d %H:%M";

        dpmsEnabled = true;
        dpmsQuickOff = true;
        dpmsStandby = "0:15:00";
        dpmsSuspend = "0:30:00";
        dpmsOff = "1:00:00";

        "Dialog.background" = "#000000";
        "Dialog.foreground" = "#dddddd";

        "Dialog.borderWidth" = 0;
        "Dialog.internalBorderWidth" = 24;

        "Dialog.bottomShadowColor" = "#000000";
        "Dialog.topShadowColor" = "#000000";
        "Dialog.shadowThickness" = 2;

        "Dialog.Button.background" = "#222222";
        "Dialog.Button.foreground" = "#eeeeee";

        "Dialog.text.background" = "#222222";
        "Dialog.text.foreground" = "#eeeeee";

        "passwd.thermometer.background" = "#000000";
        "passwd.thermometer.foreground" = "#ff0000";
      };
    };
  };
in
{
  environment.systemPackages = with pkgs; [
    xscreensaver
  ];

  home-manager.users = (mapAttrs (_: _: myXScreenSaverConfig) machine.users) // { root = myXScreenSaverConfig; };
}
