{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    signal-desktop
  ];
}
