{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    exfat
    exfat-utils
  ];
}
