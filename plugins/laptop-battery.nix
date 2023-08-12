{ config, pkgs, ... }:

{
  powerManagement = {
    enable = true;
    cpuFreqGovernor = "schedutil";
    powertop.enable = true;
  };
  
  services = {
    thermald.enable = true;
    tlp.enable = true;
  };
}
