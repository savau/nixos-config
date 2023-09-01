{ lib, pkgs, home, ... }:

{
  home.packages = with pkgs; [
    thunderbird
  ];

  home.file.".thunderbird" = {
    source = ./../../dotfiles/.thunderbird;
    recursive = true;
  };
}
