{ lib, pkgs, home, ... }:

{
  services.screen-locker = {
    enable = true;
    lockCmd = "${pkgs.i3lock}/bin/i3lock -n -c 000000";
    xautolock.enable = false;
  };
}
