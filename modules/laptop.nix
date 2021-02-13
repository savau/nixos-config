{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    powertop
    acpi
    tlp
    upower
  ];

  services.tlp.enable = true;
  services.upower.enable = true;
  powerManagement.enable = true;
}
