{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    zip unzip
    p7zip
  ];
}
