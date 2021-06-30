args'@{ config, pkgs, lib, ... }:

let
  hostname = lib.fileContents ./host;
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

  boot = {
    kernelPackages = pkgs.linuxPackages_zen;

    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot.enable = true;
    };

    tmpOnTmpfs = true;
  };

  fileSystems."/".options = lib.optionals machine.ssdOptimizations.enable [ "noatime" "nodiratime" "discard" ];

  hardware = {
    enableRedistributableFirmware = true;
  };

  services = {
    fstrim.enable = machine.ssdOptimizations.enable;
    fwupd.enable = true;

    # override nixos-hardware profile
    thermald.enable = machine.batteryManagement.enable;
  };

  networking.hostName = hostname;
  time.timeZone = machine.timezone;
}
