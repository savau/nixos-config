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
      ! Map umlauts to RIGHT ALT + <key>
      keycode 108 = Mode_switch
      keysym e = e E EuroSign
      keysym a = a A adiaresis Adiaresis
      keysym o = o O odiaresis Odiaresis
      keysym u = u U udiaresis Udiaresis
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
    # lxappearance to change theme
    lxappearance

    # theme stuff
    arc-theme
    arc-icon-theme

    # tray stuff
    volumeicon
    birdtray
  ];
}
