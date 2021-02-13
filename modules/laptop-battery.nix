{ config, pkgs, ... }:

{
  powerManagement = {
    enable = true;
    powertop.enable = true;
  };
  
  services.tlp.enable = true;
}
