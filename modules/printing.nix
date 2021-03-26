{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    simple-scan
  ];
}
