{ config, pkgs, ... }:

let
  myXmodmap = (builtins.readFile ../../dotfiles/.Xmodmap);
in
{
  home-manager.users = {
    root.home.file.".Xmodmap".text = myXmodmap;
    savau.home.file.".Xmodmap".text = myXmodmap;
  };
}
