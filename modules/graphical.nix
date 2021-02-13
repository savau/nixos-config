{ config, pkgs, ... }:

{
  imports = [
    ./graphical/main.nix
    ./graphical/fonts.nix
    ./graphical/randr.nix
    ./graphical/xfce+xmonad.nix
  ];
}
