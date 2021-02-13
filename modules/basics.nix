{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    (import ./vim.nix)
    git
    htop
  ];
}
