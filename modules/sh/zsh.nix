{ config, pkgs, lib, machine, ... }:

with lib;

let
  myZshRC = {
    home.file.".zshrc".text = "";
  };
in
{
  programs.zsh = {
    enable = true;
    ohMyZsh = {
      enable = true;
      theme = "agnoster";
      plugins = [ "git" ];
    };
  };

  home-manager.users = (mapAttrs (_: _: myZshRC) machine.users) // { root = myZshRC; };
}