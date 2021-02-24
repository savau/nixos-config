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
      myXresources = pkgs.writeText "Xresources" (builtins.readFile ../../dotfiles/.Xresources);
    in ''
      # merge Xresources:
      ${pkgs.xorg.xrdb}/bin/xrdb -merge ${myXresources}

      # apply custom keyboard layout:
      ${pkgs.xorg.xmodmap}/bin/xmodmap ~/.Xmodmap

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
