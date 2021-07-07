args'@{ config, pkgs, lib, ... }:

let
  hostname = lib.fileContents ./host;
  hostdir = ./machines/. + "/${hostname}";
  machine = import hostdir args';
  args = args' // { inherit machine; };
in
{
  imports = [
    # Include the results of the hardware scan.
    (hostdir + "/hardware-configuration.nix")

    # TODO: for each module in ./modules, import module with args instead
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

  hardware = {
    enableRedistributableFirmware = true;
  };

  services = {
    fwupd.enable = true;

    # override nixos-hardware profile
    thermald.enable = machine.batteryManagement.enable;
  };

  networking.hostName = hostname;
  time.timeZone = machine.timezone;
}
