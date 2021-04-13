{ config, pkgs, machine, ... }:

{
  powerManagement = {
    enable = machine.isLaptop;
    powertop.enable = machine.isLaptop;
    cpuFreqGovernor = "schedutil";
  };
  
  services.tlp.enable = machine.isLaptop;
}
