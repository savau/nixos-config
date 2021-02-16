{ config, pkgs, ... }:

{
  services.gnome3.gnome-keyring.enable = true;
  
  environment.systemPackages = with pkgs; [
    keepassxc
  ];
}
