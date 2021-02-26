{ config, pkgs, machine, ... }:

{
  powerManagement = {
    enable = machine.isLaptop;
    powertop.enable = machine.isLaptop;
  };
  
  services.tlp.enable = machine.isLaptop;
}
