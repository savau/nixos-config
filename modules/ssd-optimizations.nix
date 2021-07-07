{ config, pkgs, lib, machine, ... }:

if machine.ssdOptimizations.enable then {
  fileSystems."/".options = lib.optionals machine.ssdOptimizations.enable [ "noatime" "nodiratime" "discard" ];
  services.fstrim.enable = machine.ssdOptimizations.enable;
} else {}
