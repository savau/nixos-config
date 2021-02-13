{ config, pkgs, ... }:

{
  imports = [
    ./nix.nix
    (import ./nixpkgs)

    ./system.nix
    ./ssh.nix
    ./zsh.nix
    ./networking.nix
    ./basics.nix
    ./locales.nix
    (import ./graphical)
    ./laptop-battery.nix
    ./users.nix
    ./security.nix
    (import ./work)
    ./entertainment.nix
  ];
}
