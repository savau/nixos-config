{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    unzip
    zip
    p7zip
  ];
}
