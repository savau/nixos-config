{ config, pkgs, lib, ... }:

{
  services.nextcloud-client = {
    enable = true;
    startInBackground = true;
  };
}
