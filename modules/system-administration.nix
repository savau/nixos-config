{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    htop
    ntfs3g
    parted
    wget
  ];
}
