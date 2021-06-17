args@{ config, pkgs, lib, machine, ... }:

with lib;

let
  myEditors = import ../../dotfiles/vim/neovim args;
in
{
  environment.variables = {
    EDITOR = "nvim";
    GIT_EDITOR = "nvim";
  };

  home-manager.users = (mapAttrs (_: _: myEditors) machine.users) // { root = myEditors; };
}
