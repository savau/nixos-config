{ config, pkgs, callPackage, lib, machine, ... }:

let
  moduleArgs = { inherit config; inherit pkgs; inherit callPackage; inherit lib; inherit machine; };
in
{
  imports = [
    # choose ONE module in ./display-manager/
    (import ./display-manager/xfce+xmonad.nix moduleArgs)
  ];
}
