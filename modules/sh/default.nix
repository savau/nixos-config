args@{ config, pkgs, ... }:

{
  imports = [
    (import ./zsh.nix args)
  ];
}
