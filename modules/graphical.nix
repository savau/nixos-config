{ config, pkgs, ... }:

{
  imports = [
    ./graphical/main.nix

    ./graphical/display-manager.nix

    ./graphical/fonts.nix
    ./graphical/randr.nix
  ];
}
