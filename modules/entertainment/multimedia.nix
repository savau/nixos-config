{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    vlc
    youtube-dl
  ];
}
