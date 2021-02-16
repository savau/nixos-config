{ config, pkgs, ... }:

{
  imports = [
    ./display-manager.nix

    ./fonts.nix
    ./randr.nix
  ];

  services.xserver = {
    enable = true;
    layout = "us";
    xkbOptions = "caps:escape";
  };
  
  services.xserver.displayManager = {
    lightdm = {
      enable = true;
      greeters.gtk = {
        enable = true;
        theme = {
          name = "Arc-Dark";
        };
        iconTheme = {
          name = "Arc";
        };
        clock-format = "%Y-%m-%d %H:%M:%S";
        indicators = [ "~host" "~spacer" "~clock" "~separator" "~session" "~a11y" "~power" ];
        extraConfig = ''
          user-background = false
          hide-user-image = true
          reader = orca
        '';
      };
    };

    sessionCommands = let
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
      '';
    in ''
      # merge Xresources:
      ${pkgs.xorg.xrdb}/bin/xrdb -merge ${myCustomXresources}

      # apply custom keyboard layout:
      ${pkgs.xorg.xmodmap}/bin/xmodmap ${myCustomKeyboardLayout}
      
      # set background to solid black:
      xsetroot -solid black
    '';
  };

  programs.qt5ct.enable = true;

  environment.systemPackages = with pkgs; [
    # accessibility stuff
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
