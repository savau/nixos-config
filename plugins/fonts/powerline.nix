{ config, pkgs, ... }:

{
  fonts.packages = with pkgs; [
    powerline-fonts
  ];
}
