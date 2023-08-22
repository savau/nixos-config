{ lib, pkgs, home, ... }:

{
  home.sessionVariables = {
    QT_QPA_PLATFORMTHEME = "adwaita-dark";
  };

  qt = {
    enable = true;
    style.name = "adwaita-dark";
  };
}
