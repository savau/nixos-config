{ lib, pkgs, home, ... }:

{
  home.packages = with pkgs; [
    i3lock
  ];

  home.shellAliases.lock = "i3lock -n -c 000000";
}
