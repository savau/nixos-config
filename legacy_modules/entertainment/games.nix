{ config, pkgs, machine, ... }:

if machine.games.enable then {
  programs.steam.enable = true;

  environment.systemPackages = with pkgs; [
    wine
    (wine.override { wineBuild = "wine64"; })
    wineWowPackages.stable

    minetest
#   openmw  # FIXME: currently crashes with error: qt.qpa.plugin: Could not find the Qt platform plugin "xcb" in ""
    wesnoth
  ];
} else {}