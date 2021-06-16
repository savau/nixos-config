{ pkgs, lib, machine, cocConfigDir, ... }:

with lib;

let
  myCocConfig = {
    home.file.".config/nvim/coc-settings.json".text = builtins.readFile "${cocConfigDir}/haskell-language-server.json";
  };
in
{
  environment.systemPackages = with pkgs; [
    (haskell.packages.ghc8104.ghcWithPackages (pkgs: with pkgs; [ xmonad xmonad-contrib ]))
    haskell.packages.ghc8104.haskell-language-server
  ];

  home-manager.users = (mapAttrs (_: _: myCocConfig) machine.users) // { root = myCocConfig; };
}
