{ config, pkgs, machine, ... }:

if machine.batteryManagement.enable then {
  powerManagement = {
    enable = true;
    cpuFreqGovernor = "schedutil";
    powertop.enable = true;
  };
  
  services = {
    thermald.enable = true;
    tlp.enable = true;
  };
} else {}
