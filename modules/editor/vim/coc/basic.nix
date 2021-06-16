{ pkgs, lib, machine, cocConfigDir, ... }:

with lib;

let
  myCocConfig = {
    home.file.".config/nvim/coc-settings.json".text = builtins.readFile "${cocConfigDir}/basic.json";
  };
in
{
  home-manager.users = (mapAttrs (_: _: myCocConfig) machine.users) // { root = myCocConfig; };
}
