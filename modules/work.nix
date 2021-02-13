{ config, pkgs, ... }:

{
  imports = [
    ./work/main.nix
    ./work/direnv.nix
    ./work/u2w.nix
  ];
}
