{ config, pkgs, lib, machine, ... }:

with lib;

let
  myXmodmap = {
    home.file.".Xmodmap".text = (builtins.readFile ../../dotfiles/.Xmodmap);
  };
in
{
  home-manager.users = (mapAttrs (_: _: myXmodmap) machine.users) // { root = myXmodmap; };
}
