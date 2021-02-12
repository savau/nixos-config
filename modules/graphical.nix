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
    myCustomXresources = pkgs.writeText "Xresources" ''
      ! Copy selection to clipboard
      XTerm*selectToClipboard: true

      ! powerline face for agnoster zsh theme
      XTerm*faceName: Liberation Mono for Powerline
      XTerm*faceSize: 11

      ! Dark colours for xterm
      XTerm*background: black
      XTerm*foreground: lightgray

      ! Blinking cursor
      XTerm*cursorBlink: true

      ! XScreenSaver Custom Style
      xscreensaver.splash: false
      xscreensaver.Dialog.background: #000000
      xscreensaver.Dialog.bottomShadowColor: #000000
      xscreensaver.Dialog.foreground: #dddddd
      xscreensaver.Dialog.topShadowColor: #000000
      xscreensaver.Dialog.Button.background: #222222
      xscreensaver.Dialog.Button.foreground: #eeeeee
      xscreensaver.Dialog.text.background: #222222
      xscreensaver.Dialog.text.foreground: #eeeeee
      xscreensaver.Dialog.borderWidth: 0
      xscreensaver.Dialog.internalBorderWidth: 24
      xscreensaver.Dialog.shadowThickness: 2
      xscreensaver.passwd.thermometer.background: #000000
      xscreensaver.passwd.thermometer.foreground: #ff0000
      xscreensaver.dateFormat: %Y-%m-%d %H:%M
    '';
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
    # merge Xresources:
    ${pkgs.xorg.xrdb}/bin/xrdb -merge ${myCustomXresources}

    # apply custom keyboard layout:
    ${pkgs.xorg.xmodmap}/bin/xmodmap ${myCustomKeyboardLayout}
    
    # set background to solid black:
    xsetroot -solid black
  '';

  # enable handling of hotplug and sleep events by autorandr
  services.autorandr.enable = true;

  programs.qt5ct.enable = true;

  environment.systemPackages = with pkgs; [
    # X-related stuff
    xorg.xmodmap
    xclip

    # system theme stuff
    arc-theme
    arc-icon-theme
    lxappearance

    # system tray stuff
    volumeicon
    birdtray

    # display-related stuff
    arandr

    # applications
    firefox
    thunderbird
    evince
    megasync
  ];
}
