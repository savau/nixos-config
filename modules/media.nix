{ config, pkgs, ... }:

{
  programs.steam.enable = true;
  
  environment.systemPackages = with pkgs; [
    signal-desktop
    vlc
  ];
}