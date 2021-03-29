{ pkgs, lib, machine, ... }:

with lib;

let
  myCocConfig = {
    home.file.".config/nvim/coc-settings.json".text = builtins.readFile ../../../../dotfiles/.config/nvim/coc-settings/basic.json;
  };
in
{
  home-manager.users = (mapAttrs (_: _: myCocConfig) machine.users) // { root = myCocConfig; };
}
