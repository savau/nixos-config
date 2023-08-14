{ lib, pkgs, home, ... }:

{
  home.packages = with pkgs; [
    qt5ct
  ];

  home.sessionVariables = {
    QT_QPA_PLATFORMTHEME = "qt5ct";
  };

  qt = {
    enable = true;
    style.name = "qt5ct";
  };
}
