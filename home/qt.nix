{ lib, pkgs, home, ... }:

{
  qt = {
    enable = true;
    platformTheme = "gtk";
    style.name = "adwaita-dark";
  };
}
