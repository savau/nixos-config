{ config, pkgs, ... }:

{
  hardware.nitrokey.enable = true; # enables necessary udev rules

  # environment.systemPackages = with pkgs; [
  #   nitrokey-app2
  #   libnitrokey
  #   pynitrokey
  # ];
}
