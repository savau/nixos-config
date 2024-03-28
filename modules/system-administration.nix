{ config, lib, pkgs, ... }:

lib.mkMerge [
  {
    environment.systemPackages = with pkgs; [
      htop
      ncdu
      parted
      usbutils
    ];
  }

  (lib.mkIf config.services.xserver.enable {
    environment.systemPackages = with pkgs; [
      sirikali
    ];
  })
]
