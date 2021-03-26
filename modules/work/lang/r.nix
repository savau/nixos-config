{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    rstudio
  ];
}
