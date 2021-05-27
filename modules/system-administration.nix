{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    exfat-utils
    htop
    ntfs3g
    parted
    unzip
    wget
  ];
}
