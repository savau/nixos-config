{ config, pkgs, ... }:

{
  imports = [
    ./graphical/main.nix
    ./graphical/fonts.nix
    ./graphical/xfce+xmonad.nix
  ];
}
