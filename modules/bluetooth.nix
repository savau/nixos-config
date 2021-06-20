{ config, pkgs, machine, ... }:

if machine.bluetooth.enable then {
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
} else {}
