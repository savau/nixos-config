{ lib, machine, ... }:

# FIXME: make files executable for respective users
let
  myUtils.home.file = {
    ".utils/dictcc/dictcc".text     = builtins.readFile ../dotfiles/dictcc-cli/dictcc;
    ".utils/dictcc/dictcc-cli".text = builtins.readFile ../dotfiles/dictcc-cli/dictcc-cli;
  };
in
{
  home-manager.users = (lib.mapAttrs (_: _: myUtils) machine.users) // { root = myUtils; };
}
