{ config, pkgs, ... }:

{
  # enable handling of hotplug and sleep events by autorandr
  services.autorandr.enable = true;

  environment.systemPackages = with pkgs; [
    arandr
  ];
}
