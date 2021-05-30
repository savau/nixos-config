{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    exfat exfat-utils
    htop
    ntfs3g
    parted
    unzip
    wget
  ];
}
