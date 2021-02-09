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

  services.xserver.displayManager.sessionCommands = let
    myCustomKeyboardLayout = pkgs.writeText "xkb-layout" ''
      ! Map umlauts to ALT + <key>
      keysym Alt_L = Mode_switch
      keysym e = e E EuroSign
      keysym a = a A adiaeresis Adiaeresis
      keysym o = o O odiaeresis Odiaeresis
      keysym u = u U udiaeresis Udiaeresis
      keysym s = s S ssharp

      ! disable capslock
      remove Lock = Caps_Lock
    '';
  in ''
    # apply custom keyboard layout:
    ${pkgs.xorg.xmodmap}/bin/xmodmap ${myCustomKeyboardLayout}
    
    # set background to solid black:
    xsetroot -solid black
  '';

  environment.systemPackages = with pkgs; [
    # X-related stuff
    xorg.xmodmap

    # system theme stuff
    lxappearance
    arc-theme
    arc-icon-theme

    # system tray stuff
    volumeicon
    birdtray

    # applications
    firefox
    thunderbird
    evince
    libreoffice
    texstudio
  ];
}
