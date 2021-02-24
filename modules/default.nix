{ config, pkgs, ... }:

{
  imports = [
    ./nix.nix
    (import ./nixpkgs)

    ./home-manager.nix

    ./basics.nix
    ./git.nix
    (import ./graphical)
    ./i18n.nix
    ./laptop-battery.nix
    ./media.nix
    ./networking.nix
    ./security.nix
    ./ssh.nix
    ./users.nix
    (import ./work)
    ./xmodmap.nix
    ./zsh.nix
  ];
}
