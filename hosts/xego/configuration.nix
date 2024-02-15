{ config, lib, pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan
    ./hardware-configuration.nix

    # Plug-ins
    ./../../plugins/android.nix
    ./../../plugins/audio.nix
    ./../../plugins/bluetooth.nix
    ./../../plugins/fonts/powerline.nix
    ./../../plugins/laptop-battery.nix
    ./../../plugins/lightdm.nix
    ./../../plugins/nitrokey.nix
    ./../../plugins/printing.nix
    ./../../plugins/ssh.nix
    ./../../plugins/video.nix
    ./../../plugins/virtualisation.nix
    ./../../plugins/xfce.nix

    <home-manager/nixos>
  ];

  boot.initrd.luks.devices.luksroot = {
    device = "/dev/disk/by-uuid/869d3b66-b638-48cf-aee5-594cc5de9b4b";
    preLVM = true;
    allowDiscards = true;
  };

  # Use the systemd-boot EFI loader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.tmp.cleanOnBoot = true;

  # SSD optimizations
  fileSystems."/".options = [ "noatime" "nodiratime" "discard" ];
  services.fstrim.enable = true;

  networking.hostName = "xego";

  time.timeZone = "Europe/Berlin";

  console = {
    font = "Lat2-Terminus16";
    keyMap = lib.mkForce "us";
    useXkbConfig = true;  # use xkbOptions in tty
  };

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_TIME = "en_DK.UTF-8";
    };
    supportedLocales = [
      "en_DK.UTF-8/UTF-8"
      "en_US.UTF-8/UTF-8"
      "en_GB.UTF-8/UTF-8"
      "de_DE.UTF-8/UTF-8"
    ];
  };

  services.xserver = {
    enable = true;

    xkb.layout = "us";      # Configure keymap in X11
    libinput.enable = true; # Enable touchpad support

    displayManager.defaultSession = "xfce+xmonad";

    displayManager.sessionCommands = ''
      # Set desktop background to solid black
      # xsetroot -solid black

      ${pkgs.xorg.xrdb}/bin/xrdb -merge <${pkgs.writeText "Xresources" ''
        XTerm*cursorBlink: true
        XTerm*selectToClipboard: true
        XTerm*background: black
        XTerm*foreground: white
        XTerm*faceName: Liberation Mono for Powerline
        XTerm*faceSize: 10
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

    windowManager.xmonad.enable = true;
  };

  # System packages
  environment.systemPackages = with pkgs; [
    gparted
  ];

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    enableBrowserSocket = true;
    pinentryFlavor = "gnome3";
  };
  services.dbus.packages = [ pkgs.gcr ]; # https://github.com/nix-community/home-manager/blob/a2523ea0343b056ba240abbac90ab5f116a7aa7b/modules/services/gpg-agent.nix#L206-L212

  services.gnome.gnome-keyring.enable = true;
  security.pam.services.lightdm.enableGnomeKeyring = true;


  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = false;

  home-manager.users.savau = import ./../../users/savau/home.nix;
  users.users.savau = {
    isNormalUser = true;
    extraGroups = [
      "audio" "video"
      "nitrokey"
      "networkmanager"
      "lp" "scanner"
      "systemd-journal"
      "docker"
      "wheel"
    ];
  };

  home-manager.users.root = {
    programs.home-manager.enable = true;
    home.stateVersion = "24.05";
    imports = [
      ./../../users/savau/plugins/neovim.nix
      ./../../users/savau/plugins/zsh.nix
    ];
  };
  users.users.root.shell = pkgs.zsh;

  programs.zsh.enable = true;

  system.stateVersion = "24.05";
}
