{ config, pkgs, machine, ... }:

{
  powerManagement = {
    enable = machine.isLaptop;
    powertop.enable = machine.isLaptop;
    cpuFreqGovernor = "ondemand";
  };
  
  services.tlp.enable = machine.isLaptop;
}
