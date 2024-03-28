{ lib, pkgs, home, ... }:

{
  home.packages = with pkgs; [
    aspell
    aspellDicts.en
    aspellDicts.de
  ];
}
