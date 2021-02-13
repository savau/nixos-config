{ config, pkgs, ... }:\

{
  fonts = {
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      corefonts
      source-code-pro
      source-sans-pro
      source-serif-pro
      dejavu_fonts
      powerline-fonts
    ];
  };
}
