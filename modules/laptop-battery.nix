{ config, pkgs, machine, ... }:

if machine.batteryManagement.enable then {
  powerManagement = {
    enable = true;
    powertop.enable = true;
    cpuFreqGovernor = "schedutil";
  };
  
  services.tlp.enable = true;
} else {}
