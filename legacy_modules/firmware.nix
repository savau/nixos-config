{ config, pkgs, ... }:

{
  hardware.enableRedistributableFirmware = true;
  services.fwupd.enable = true;
}
