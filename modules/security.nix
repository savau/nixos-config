{ config, pkgs, ... }:

{
  environment.systemPackages = [
    keepassxc
  ];
}
