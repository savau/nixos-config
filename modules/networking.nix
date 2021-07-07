{ config, pkgs, machine, ... }:

{
  networking = {
    hostName = machine.hostname;
    networkmanager.enable = true;
  };

  environment.systemPackages = with pkgs; [
    wget
  ];
}
