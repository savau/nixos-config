args'@{ config, pkgs, lib, ... }:

with lib;

let
  hostdir = ./machines/. + "/${removeSuffix "\n" (builtins.readFile ./host)}";
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
  };

  networking.hostName = machine.hostname;

  time.timeZone = machine.timezone;
}
