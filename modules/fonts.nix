{ config, pkgs, ... }:

{
  fonts = {
    enableGhostscriptFonts = true;
    packages = with pkgs; [
      source-code-pro
      source-sans-pro
      source-serif-pro
      dejavu_fonts
    ];
  };
}
