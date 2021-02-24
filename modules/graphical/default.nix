{ config, pkgs, ... }:

{
  imports = [
    ./display-manager.nix

    ./fonts.nix
    ./lightdm.nix
    ./randr.nix
    ./xscreensaver.nix
  ];

  services.xserver = {
    enable = true;
    layout = "us";
    #xkbOptions = "caps:escape";

    displayManager.sessionCommands = let
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
      '';
      myCustomKeyboardLayout = pkgs.writeText "xkb-layout" ''
        ! Map umlauts to ALT + <key>
        keysym Alt_L = Mode_switch
        keysym e = e E EuroSign
        keysym a = a A adiaeresis Adiaeresis
        keysym o = o O odiaeresis Odiaeresis
        keysym u = u U udiaeresis Udiaeresis
        keysym s = s S ssharp
        ! Disable Capslock
        clear Lock
      '';
    in ''
      # merge Xresources:
      ${pkgs.xorg.xrdb}/bin/xrdb -merge ${myCustomXresources}

      # apply custom keyboard layout:
      ${pkgs.xorg.xmodmap}/bin/xmodmap ${myCustomKeyboardLayout}
      
      # set background to solid black:
      xsetroot -solid black

      # start xscreensaver:
      xscreensaver -no-splash &
    '';
  };

  programs.qt5ct.enable = true;

  environment.systemPackages = with pkgs; [
    # accessibility stuff
    at_spi2_atk at_spi2_core speechd
    orca

    # X-related stuff
    xorg.xmodmap
    xclip

    # system-tool GUIs
    gparted

    # system theme stuff
    arc-theme
    arc-icon-theme
    lxappearance

    # system tray stuff
    volumeicon
    birdtray

    # applications
    firefox
    thunderbird
    evince
    megasync
  ];
}
