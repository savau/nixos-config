args'@{ config, pkgs, lib, ... }:

with lib;

let
  hostname = builtins.readFile ./host;
  hostdir = ./machines/. + "/${hostname}";
  machine = import hostdir;
  args = args' // { inherit machine; };
in
{
  imports = [
    # Include the results of the hardware scan.
    (hostdir + "/hardware-configuration.nix")

    (import ./modules args)
  ];

  hardware = {
    bluetooth.enable = machine.bluetoothEnabled;
    pulseaudio = {
      enable = true;
      support32Bit = true;
      package = pkgs.pulseaudioFull;
      extraConfig = if machine.bluetoothEnabled then ''
        unload-module module-bluetooth-policy
        load-module module-bluetooth-policy auto_switch=2
        load-module module-switch-on-connect
      '' else "";  # reload with auto_switch=2 to make the module-bluetooth-policy switch to headset policy when an audio input stream appears
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
      allowDiscards = machine.ssdOptimized;
    };

    tmpOnTmpfs = true;
  };

  fileSystems."/".options = optionals machine.ssdOptimized [ "noatime" "nodiratime" "discard" ];

  services = {
    fstrim.enable = machine.ssdOptimized;
    fwupd.enable = true;

    # override nixos-hardware profile
    thermald.enable = machine.isLaptop;

    blueman.enable = machine.bluetoothEnabled;
  };

  networking.hostName = machine.hostname;

  time.timeZone = machine.timezone;
}
