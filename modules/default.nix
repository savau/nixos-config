{ config, pkgs, lib, machine, ... }:

let
  moduleArgs = { inherit config; inherit pkgs; inherit lib; inherit machine; };
in
{
  imports = [
    ./nix.nix
    (import ./nixpkgs)

    ./home-manager.nix

    ./basics.nix
    (import ./git.nix moduleArgs)
    (import ./graphical moduleArgs)
    ./i18n.nix
    (import ./laptop-battery.nix moduleArgs)
    ./media.nix
    ./networking.nix
    ./security.nix
    ./ssh.nix
    (import ./users.nix moduleArgs)
    (import ./work)
    ./zsh.nix
  ];
}
