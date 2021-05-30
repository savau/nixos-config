args@{ config, pkgs, ... }:

{
  imports = [
    (import ./zsh args)
  ];
}
