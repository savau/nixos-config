{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    git
    htop
    (import ./vim.nix)
  ];
}
