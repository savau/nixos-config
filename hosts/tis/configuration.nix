{ config, lib, pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan
    ./hardware-configuration.nix

    # Plug-ins
    ./../../plugins/audio.nix
    ./../../plugins/bluetooth.nix
    ./../../plugins/fonts/powerline.nix
    ./../../plugins/laptop-battery.nix
    ./../../plugins/lightdm.nix
    ./../../plugins/printing.nix
    ./../../plugins/ssh.nix
    ./../../plugins/video.nix

    <home-manager/nixos>
  ];

  # Use the systemd-boot EFI loader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "tis";

  time.timeZone = "Europe/Berlin";

  console = {
    font = "Lat2-Terminus16";
    keyMap = lib.mkForce "de";
    useXkbConfig = true; # use xkbOptions in tty
  };

  i18n = {
    defaultLocale = "de_DE.UTF-8";
    extraLocaleSettings = {
      LC_TIME = "en_DK.UTF-8";
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

    displayManager.defaultSession = "xfce+xmonad";

    displayManager.sessionCommands = ''
      ${pkgs.xorg.xrdb}/bin/xrdb -merge <${pkgs.writeText "Xresources" ''
        ! Xresources

        ! Blinking cursor
        XTerm*cursorBlink: true

        ! Copy selection to clipboard
        XTerm*selectToClipboard: true

        ! Dark colours for xterm
        XTerm*background: black
        XTerm*foreground: lightgray

        ! Powerline font for agnoster zsh theme
        XTerm*faceName: Liberation Mono for Powerline
        XTerm*faceSize: 11
      ''}
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
    arc-icon-theme  # add missing icons
    gparted
    vim
  ];


  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = false;

  home-manager.users.savau = import ./../../users/savau/home.nix;
  users.users.savau = {
    isNormalUser = true;
    extraGroups = [
      "audio" "video"
      "networkmanager"
      "lp" "scanner"
      "systemd-journal"
      "wheel"
    ];
  };

  system.stateVersion = "23.05";

  # TODO: replace below config options with module contents

  # configuration options for Linux Unified Key Setup (LUKS) disk encryption
  # luks.fullDiskEncryption.enable = false;

  # time zone this machine typically resides in
  # timezone = "Europe/Berlin";

  # system shell to use for all users on this machine including root and other system users
  # can be overriden per user via users.<username>.shell
  # systemShell = pkgs.zsh;

  # # the physical keyboard layout on this machine
  # keyboardLayout = {
  #   layout = "de,us";
  #   xkbOptions = "grp:rctrl_rshift_toggle";
  # };

  # # configuration options for audio services
  # audio = {
  #   enable = true;
  # };

  # # configuration options for battery management and optimization services
  # batteryManagement = {
  #   enable = true;
  # };

  # # configuration options for bluetooth services
  # bluetooth = {
  #   enable = true;
  # };

  # # configuration options for game services
  # games = {
  #   enable = true;
  # };

  # # configuration options for SSD optimizations
  # ssdOptimizations = {
  #   enable = true;
  # };
}
