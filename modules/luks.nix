{ config, machine, ... }:

# TODO: support partial disk encryption
if machine.luks.fullDiskEncryption.enable then {
  boot.initrd.luks.devices.luksroot = {
    device = "/dev/disk/by-uuid" + "/${machine.luks.fullDiskEncryption.root.uuid}";
    preLVM = true;
    allowDiscards = machine.ssdOptimizations.enable;
  };
} else {}
