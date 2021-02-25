{ config, pkgs, lib, ... }:

with lib;

let
  myXmodmap = {
    home.file.".Xmodmap".text = (builtins.readFile ../../dotfiles/.Xmodmap);
  };
in
{
  home-manager.users = mkMerge [ { root = myXmodmap; } (mapAttrs (_: _: myXmodmap) (import ../../definitions/users.nix pkgs)) ];
}
