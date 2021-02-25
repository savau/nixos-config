{ config, pkgs, ... }:

let  
  myGtk = {
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
    #lxappearance
  ];

  home-manager.users = {
    root.gtk = myGtk;
    savau.gtk = myGtk;
  };
}
