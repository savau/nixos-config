{ config, lib, pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan
    ./hardware-configuration.nix

    <home-manager/nixos>
  ];

  # Use the systemd-boot EFI loader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "tis";

  time.timeZone = "Europe/Berlin";

  i18n.defaultLocale = "de_DE.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = lib.mkForce "de";
    useXkbConfig = true; # use xkbOptions in tty
  };

  # Enable sound
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  services.xserver.enable = true;
  # Configure keymap in X11
  services.xserver.layout = "de";
  # Enable touchpad support
  services.xserver.libinput.enable = true;
  services.xserver.desktopManager.xterm.enable = true;
  services.xserver.desktopManager.xfce.enable = true;
  services.xserver.displayManager.lightdm = {
    enable = true;
    greeters.slick = {
      enable = true;
      theme.name = "Arc-Dark";
    };
  };

  # Enable CUPS to print documents
  services.printing.enable = true;


  # System packages
  environment.systemPackages = with pkgs; [
    curl
    git
    htop
    vim
    wget
  ];


  home-manager.useGlobalPkgs = true;

  home-manager.users.savau = import ./../../users/savau/home.nix;
  users.users.savau = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
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
