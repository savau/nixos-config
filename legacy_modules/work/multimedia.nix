{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # images
    gimp

    # audio
    audacity
  ];
}
