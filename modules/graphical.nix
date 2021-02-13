{ config, pkgs, ... }:

{
  imports = [
    ./graphical/main.nix

    ./graphical/display-manager/xfce+xmonad.nix

    ./graphical/fonts.nix
    ./graphical/randr.nix
  ];
}
