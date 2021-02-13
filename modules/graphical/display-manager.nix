{ config, pkgs, ... }:

{
  imports = [
    # choose ONE module in ./display-manager/
    ./display-manager/xfce+xmonad.nix
  ];
}
