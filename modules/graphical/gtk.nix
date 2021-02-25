{ config, pkgs, ... }:

let  
  myGtkConfig = {
    enable = true;

    theme = null;
    iconTheme = null;
    font = null;
  };
in
{
  environment.systemPackages = with pkgs; [
    arc-theme
    arc-icon-theme
  ];

  home-manager.users = {
    root.gtk = myGtkConfig;
    savau.gtk = myGtkConfig;
  };
}
