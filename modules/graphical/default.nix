args@{ config, pkgs, ... }:

{
  imports = [
    (import ./display-manager args)

    (import ./fonts.nix args)
    (import ./gtk.nix args)
    (import ./lightdm.nix args)
    (import ./randr.nix args)
    (import ./xmodmap.nix args)
    (import ./xscreensaver.nix args)
  ];

  services.xserver = {
    enable = true;

    layout = "us";
    xkbOptions = "";

    displayManager.sessionCommands = let
      myXresources = pkgs.writeText "Xresources" (builtins.readFile ../../dotfiles/.Xresources);
      myXmodmap = pkgs.writeText "xkb-layout" (builtins.readFile ../../dotfiles/.Xmodmap);
    in ''
      # merge Xresources:
      ${pkgs.xorg.xrdb}/bin/xrdb -merge ${myXresources}

      # apply custom keyboard layout:
      ${pkgs.xorg.xmodmap}/bin/xmodmap ${myXmodmap}

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
