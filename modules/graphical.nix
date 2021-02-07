{ config, pkgs, ... }:

{
  imports = [ ./xfce-xmonad.nix ];
  services.xserver = {
    enable = true;
    layout = "us";
    xkbOptions = "caps:escape";
  };

  fonts = {
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      corefonts
      source-code-pro
      source-sans-pro
      source-serif-pro
      dejavu_fonts
      powerline
    ];
  };

  environment.systemPackages = with pkgs; [
    lxappearance
    
    arc-theme
    arc-icon-theme
    volumeicon
    birdtray
  ];
}
