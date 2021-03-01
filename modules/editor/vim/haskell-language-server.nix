{ pkgs, lib, machine, ... }:

with lib;

let
  myCocConfig = {
    home.file.".config/nvim/coc-settings.json".text = builtins.readFile ../../../dotfiles/.config/nvim/coc-settings.json;
  };
in
{
  environment.systemPackages = with pkgs; [
    ghc
    haskell.packages.ghc8104.haskell-language-server
  ];

  home-manager.users = (mapAttrs (_: _: myCocConfig) machine.users) // { root = myCocConfig; };
}
