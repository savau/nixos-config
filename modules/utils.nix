{ lib, machine, ... }:

let
  myDictCCCli = {
    home.file.".utils/" = builtins.readDir ../dotfiles/dictcc-cli;
  };
{
  home-manager.users = (lib.mapAttrs (_: _: myDictCCCli) machine.users) // { root = myDictCCCli; };
}
