{ config, lib, pkgs, ... }:

{
  security.sudo = {
    enable = true;
    wheelNeedsPassword = false;
    execWheelOnly = true;
  };
}
