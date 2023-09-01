{ lib, pkgs, home, ... }:

{
  home.packages = with pkgs; [
    firefox
  ];

  home.file.".mozilla/firefox" = {
    source = ./../../dotfiles/.mozilla/firefox;
    recursive = true;
  };
}
