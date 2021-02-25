{ config, pkgs, lib, ... }:

let
  moduleArgs = { inherit config; inherit pkgs; inherit lib; inherit machine; };
  
  # TODO: use machine type
  machine = {
    hostname = "xego";
    timezone = "Europe/Berlin";

    systemShell = import ./system-shell.nix;
    users = import ./users.nix;
  };
in
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix

    (import ../../modules moduleArgs)
  ];

  hardware = {
    #bluetooth.enable = true;
    pulseaudio = {
      enable = true;
      support32Bit = true;
      package = pkgs.pulseaudioFull;
      #extraConfig = ''
      #  unload-module module-bluetooth-policy
      #  load-module module-bluetooth-policy auto_switch=2
      #  load-module module-switch-on-connect
      #'';  # reload with auto_switch=2 to make the module-bluetooth-policy switch to headset policy when an audio input stream appears
    };
    opengl.driSupport32Bit = true;
    enableRedistributableFirmware = true;
  };

  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;

    initrd.luks.devices.luksroot = {
      device = "/dev/disk/by-uuid/fd90341e-768c-43c8-b725-855d71ea7722";
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

    #blueman.enable = true;
  };

  networking.hostName = machine.hostname;

  time.timeZone = machine.timezone;
}
