{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    jetbrains.idea-community
  ];
}
