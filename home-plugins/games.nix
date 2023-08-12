{ lib, pkgs, home, ... }:

{
  programs.steam.enable = true;

  home.packages = with pkgs; [
    wine
    (wine.override { wineBuild = "wine64"; })
    wineWowPackages.stable

    minetest
#   openmw  # FIXME: currently crashes with error: qt.qpa.plugin: Could not find the Qt platform plugin "xcb" in ""
    wesnoth
  ];
}
