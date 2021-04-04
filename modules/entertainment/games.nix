{ config, pkgs, machine, ... }:

if machine.gameEnabled
then
{
  programs.steam.enable = true;

  environment.systemPackages = with pkgs; [
    minetest
  ];
}
else {}
