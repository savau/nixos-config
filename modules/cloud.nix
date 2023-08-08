{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    nextcloud-client
    # rclone
    # rclone-browser
  ];
}
