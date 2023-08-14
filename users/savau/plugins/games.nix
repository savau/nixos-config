{ lib, pkgs, home, ... }:

{
  home.packages = with pkgs; [
    steam

    # wine
    # (wine.override { wineBuild = "wine64"; })
    # wineWowPackages.stable

    minetest
#   openmw  # FIXME: currently crashes with error: qt.qpa.plugin: Could not find the Qt platform plugin "xcb" in ""
    wesnoth
  ];
}
