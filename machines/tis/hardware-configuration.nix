{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "nvme" "rtsx_pci_sdmmc" ];
  boot.initrd.kernelModules = [ "dm-snapshot" ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/88fd0014-7e62-4e74-81e7-0dc6a471f88b";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/AE8E-8582";
      fsType = "vfat";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/167845b0-5783-44b8-916f-50996799d647"; }
    ];

  powerManagement.cpuFreqGovernor = lib.mkDefault "schedutil";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
