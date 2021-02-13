{ config, pkgs, ... }:

{
  imports = [
    ./graphical/main.nix
    ./graphical/xfce+xmonad.nix
  ];
}
