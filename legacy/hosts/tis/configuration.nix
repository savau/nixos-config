{ config, lib, pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan
    ./hardware-configuration.nix

    # Plug-ins
    ./../../plugins/audio.nix
    ./../../plugins/bluetooth.nix
    ./../../plugins/laptop-battery.nix
    ./../../plugins/lightdm.nix
    ./../../plugins/printing.nix
    ./../../plugins/ssh.nix
    ./../../plugins/video.nix
    ./../../plugins/xfce.nix

    <home-manager/nixos>
  ];

  # Use the systemd-boot EFI loader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices.luksroot = {
    device = "/dev/disk/by-uuid/f599d151-c3ee-4498-ac61-15885d03a1b6";
    preLVM = true;
    allowDiscards = true;
  };

  boot.tmp.cleanOnBoot = true;

  # SSD optimizations
  fileSystems."/".options = [ "noatime" "nodiratime" "discard" ];
  services.fstrim.enable = true;

  networking.hostName = "tis";

  time.timeZone = "Europe/Berlin";

  console = {
    font = "Lat2-Terminus16";
    keyMap = lib.mkForce "de";
    useXkbConfig = true;  # use xkbOptions in tty
  };

  i18n = {
    defaultLocale = "de_DE.UTF-8";
    extraLocaleSettings = {
      LC_TIME = "de_DE.UTF-8";
    };
    supportedLocales = [
      "en_US.UTF-8/UTF-8"
      "en_GB.UTF-8/UTF-8"
      "en_DK.UTF-8/UTF-8"
      "de_DE.UTF-8/UTF-8"
    ];
  };

  services.xserver = {
    enable = true;

    layout = "de";          # Configure keymap in X11
    libinput.enable = true; # Enable touchpad support

    displayManager.defaultSession = "xfce+windowmaker";

    # TODO: create Xresources dotfile and use it here
    displayManager.sessionCommands = ''
      # Merge Xresurces:
      ${pkgs.xorg.xrdb}/bin/xrdb -merge <${pkgs.writeText "Xresources" ''
        ! Xresources

        ! Blinking cursor
        XTerm*cursorBlink: true

        ! Copy selection to clipboard
        XTerm*selectToClipboard: false

        ! Dark colours for xterm
        XTerm*background: black
        XTerm*foreground: white

        ! Powerline font for agnoster zsh theme
        XTerm*faceName: Liberation Mono for Powerline
        XTerm*faceSize: 10
      ''}

      # Set desktop background to solid black
      xsetroot -solid black
    '';

    desktopManager = {
      xterm.enable = true;
      xfce = {
        enable = true;
        noDesktop = true;
        enableXfwm = false;
        enableScreensaver = false;
      };
    };

    windowManager = {
      windowmaker.enable = true;
      xmonad.enable = true;
    };
  };

  programs.gnupg.agent.enable = true;
  programs.seahorse.enable = true;

  services.gnome.gnome-keyring.enable = true;
  security.pam.services.lightdm.enableGnomeKeyring = true;

  # System packages
  environment.systemPackages = with pkgs; [
    gparted
    vim
  ];


  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = false;

  home-manager.users.ishka = import ./../../users/ishka/home.nix;
  users.users.ishka = {
    isNormalUser = true;
    extraGroups = [
      "audio" "video"
      "networkmanager"
      "lp" "scanner"
      "systemd-journal"
      "wheel"
    ];
  };
  home-manager.users.barth = { ... }: {
    imports = [ ./../../users/ishka/home.nix ];
    home.username = lib.mkForce "barth";
    home.homeDirectory = lib.mkForce "/home/barth";
  };
  users.users.barth = {
    isNormalUser = true;
    extraGroups = [
      "audio" "video"
      "networkmanager"
      "lp" "scanner"
      "systemd-journal"
      "wheel"
    ];
  };

  users.users.root.shell = pkgs.bash;

  system.stateVersion = "23.05";
}
