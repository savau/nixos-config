{ config, pkgs, machine, ... }:

{
  networking = {
    hostName = machine.hostname;
    networkmanager = {
      enable = true;
      # plugins = [ NetworkManager-openconnect ];
    };
  };

  environment.systemPackages = with pkgs; [
    wget
    openconnect
  ];
}
