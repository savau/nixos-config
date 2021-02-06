{ config, pkgs, lib, ... }:

{
  imports = 
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix

      ../../modules/nix.nix
      ../../modules/nixpkgs.nix
      ../../modules/networking.nix
      ../../modules/basics.nix
      ../../modules/locales.nix
      ../../modules/workstation.nix
      ../../modules/graphical.nix
      ../../modules/laptop.nix
      ../../modules/users.nix
      ../../modules/entertainment.nix
      ../../modules/security.nix
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

    # https://bugzilla.kernel.org/show_bug.cgi?id=110941
    #kernelParams = [ "intel_pstate=no_hwp" ];

    initrd.luks.devices.luksroot = {
      device = "/dev/disk/by-uuid/d3e66e51-1ce9-4609-a63a-a09c4e72338b";
      preLVM = true;
      allowDiscards = true;
    };
  };

  # supposedly better for SSDs
  fileSystems."/".options = [ "noatime" "nodiratime" "discard" ];

  services = {
    fstrim.enable = true;
    fwupd.enable = true;

    # override nixos-hardware profile
    thermald.enable = true;
  };

  networking.hostName = "xego";
}
