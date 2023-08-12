{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    jdk
    jetbrains.idea-community
  ];
}
