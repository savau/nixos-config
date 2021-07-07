{ config, pkgs, lib, machine, ... }:

if machine.ssdOptimizations.enable then {
  fileSystems."/".options = [ "noatime" "nodiratime" "discard" ];
  services.fstrim.enable = true;
} else {}
