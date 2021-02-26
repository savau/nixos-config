{ config, pkgs, callPackage, lib, machine, ... }:

let
  moduleArgs = { inherit config; inherit pkgs; inherit callPackage; inherit lib; inherit machine; };
in
{
  imports = [
    ./nix.nix
    (import ./nixpkgs)

    (import ./home-manager.nix moduleArgs)

    (import ./basics.nix moduleArgs)
    (import ./git.nix moduleArgs)
    (import ./graphical moduleArgs)
    (import ./i18n.nix moduleArgs)
    (import ./laptop-battery.nix moduleArgs)
    (import ./media.nix moduleArgs)
    (import ./networking.nix moduleArgs)
    (import ./security.nix moduleArgs)
    (import ./ssh.nix moduleArgs)
    (import ./users.nix moduleArgs)
    (import ./work moduleArgs)
    (import ./zsh.nix moduleArgs)
  ];
}
