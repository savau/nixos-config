{ config, pkgs, machine, ... }:

if machine.gameEnabled
then
{
  programs.steam.enable = true;

  environment.systemPackages = with pkgs; [
    minetest
    openmw  # FIXME: currently crashes with error: qt.qpa.plugin: Could not find the Qt platform plugin "xcb" in ""
  ];
}
else {}
