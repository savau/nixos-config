{ config, pkgs, ... }:

{
  networking.networkmanager = {
    enable = true;
    # plugins = [ NetworkManager-openconnect ];
  };

  environment.systemPackages = with pkgs; [
    curl
    git
    openconnect
    wget
  ];
}
