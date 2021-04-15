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

  boot = {
    initrd.luks.devices.luksroot = {
      device = "/dev/disk/by-uuid" + "/${machine.luksRootUUID}";
      preLVM = true;
      allowDiscards = machine.ssdOptimized;
    };

    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot.enable = true;
    };

    tmpOnTmpfs = true;
  };

  fileSystems."/".options = optionals machine.ssdOptimized [ "noatime" "nodiratime" "discard" ];

  hardware = {
    enableRedistributableFirmware = true;
  };

  services = {
    fstrim.enable = machine.ssdOptimized;
    fwupd.enable = true;

    # override nixos-hardware profile
    thermald.enable = machine.isLaptop;
  };

  networking.hostName = machine.hostname;
  time.timeZone = machine.timezone;
}
