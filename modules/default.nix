{ config, pkgs, ... }:

{
  imports = [
    ./nix.nix
    (import ./nixpkgs)

    ./basics.nix
    (import ./graphical)
    ./i18n.nix
    ./laptop-battery.nix
    ./media.nix
    ./networking.nix
    ./system.nix
    ./security.nix
    ./ssh.nix
    ./users.nix
    (import ./work)
    ./zsh.nix
  ];
}
