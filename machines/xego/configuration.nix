{ config, pkgs, lib, ... }:

let
  moduleArgs = { inherit config; inherit pkgs; inherit lib; inherit machine; };
  
  # TODO: use machine type
  machine = {
    hostname = "xego";

    # UUID of the luks root partition
    luksRootUUID = "fd90341e-768c-43c8-b725-855d71ea7722";

    # Time zone this machine typically resides in
    timezone = "Europe/Berlin";

    # Machine users
    users = import ./users.nix;
    # System shell to use for all machine users including root. May be overriden per user via users.<user>.shell
    systemShell = import ./system-shell.nix;

    # Enables bluetooth services on this device
    bluetoothEnabled = true;

    # Enables battery-management services on this device
    isLaptop = true;

    # Enables SSD optimizations (enable if NixOS is installed on a SSD)
    ssdOptimized = true;
  };
in
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix

    (import ../../modules moduleArgs)
  ];

  hardware = {
    bluetooth.enable = true;
    pulseaudio = {
      enable = true;
      support32Bit = true;
      package = pkgs.pulseaudioFull;
      extraConfig = ''
        unload-module module-bluetooth-policy
        load-module module-bluetooth-policy auto_switch=2
        load-module module-switch-on-connect
      '';  # reload with auto_switch=2 to make the module-bluetooth-policy switch to headset policy when an audio input stream appears
    };
    opengl.driSupport32Bit = true;
    enableRedistributableFirmware = true;
  };

  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;

    initrd.luks.devices.luksroot = {
      device = "/dev/disk/by-uuid" + "/${machine.luksRootUUID}";
      preLVM = true;
      allowDiscards = true;
    };

    tmpOnTmpfs = true;
  };

  # supposedly better for SSDs
  fileSystems."/".options = [ "noatime" "nodiratime" "discard" ];

  services = {
    fstrim.enable = true;
    fwupd.enable = true;

    # override nixos-hardware profile
    thermald.enable = true;

    blueman.enable = true;
  };

  networking.hostName = machine.hostname;

  time.timeZone = machine.timezone;
}
