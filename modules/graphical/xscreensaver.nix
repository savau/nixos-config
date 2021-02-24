{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    xscreensaver
  ];
}
