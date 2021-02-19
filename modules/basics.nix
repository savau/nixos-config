{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    htop
    (import ./vim.nix)
  ];
}
