args@{ config, pkgs, machine, ... }:

let
  keyboardAttrOrDef = attrName: defVal: (
    if builtins.hasAttr "keyboardLayout" machine
    then (
      if builtins.hasAttr attrName machine.keyboardLayout
      then machine.keyboardLayout.${attrName}
      else defVal
    )
    else defVal
  );
in {
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

    layout     = keyboardAttrOrDef "layout"     "us";
    xkbVariant = keyboardAttrOrDef "xkbVariant" "";
    xkbOptions = keyboardAttrOrDef "xkbOptions" "";

    gdk-pixbuf.modulePackages = [ pkgs.librsvg ];

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
      #xscreensaver -no-splash &
    '';
  };

  qt.platformTheme = "qt5ct";

  environment.systemPackages = with pkgs; [
    # accessibility stuff
    #at-spi2-atk at-spi2-core speechd
    #orca

    # X-related stuff
    xorg.xmodmap
    xclip

    # system-tool GUIs
    gparted

    # system tray stuff
    #volumeicon
    #birdtray

    #libnotify

    # add missing icons
    arc-icon-theme

    # applications
    firefox
    chromium
    evince
    # TODO picture viewer
  ];

}
