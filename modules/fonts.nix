{ config, pkgs, ... }:

{
  fonts = {
    enableGhostscriptFonts = true;
    packages = with pkgs; [
      corefonts
    ];
  };
}
