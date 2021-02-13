{ config, pkgs, ... }:

{
  imports = [
    ./nix.nix
    (import ./nixpkgs)

    ./basics.nix
    ./entertainment.nix
    (import ./graphical)
    ./i18n.nix
    ./laptop-battery.nix
    ./networking.nix
    ./system.nix
    ./security.nix
    ./ssh.nix
    ./users.nix
    (import ./work)
    ./zsh.nix
  ];
}
