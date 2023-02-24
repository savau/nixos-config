{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    nextcloud-client
  ];
}
