{ config, pkgs, ... }:

{
  imports = [
    ./nix.nix
    (import ./nixpkgs)

    ./basics.nix
    ./entertainment.nix
    (import ./graphical)
    ./laptop-battery.nix
    ./locales.nix
    ./networking.nix
    ./system.nix
    ./security.nix
    ./ssh.nix
    ./users.nix
    (import ./work)
    ./zsh.nix
  ];
}
