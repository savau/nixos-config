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
      powerline-fonts
    ];
  };

  # set background to solid black
  services.xserver.displayManager.sessionCommands = ''
    xsetroot -solid black
  '';

  environment.systemPackages = with pkgs; [
    # lxappearance to change theme
    lxappearance

    # theme stuff
    arc-theme
    arc-icon-theme

    # tray stuff
    volumeicon
    birdtray

    # convenience stuff
    #pcmanfm
  ];
}
