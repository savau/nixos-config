{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    htop
    ncdu
    parted
    usbutils
  ];
}
