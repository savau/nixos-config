{ lib, pkgs, home, ... }:

{
  home.packages = with pkgs; [
    qt5ct
    libsForQt5.qtstyleplugins
  ];

  home.sessionVariables = {
    QT_QPA_PLATFORMTHEME = "gtk2";
  };

  qt = {
    enable = true;
    style.name = "gtk2";
  };
}
