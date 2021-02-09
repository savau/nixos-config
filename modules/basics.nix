{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    (import ./vim.nix)
    ncurses icu.dev zlib  # pre-requisites for Haskell Language Server
    git
    htop
  ];

  services = {
    openssh.enable = true;  # allow to ssh in
  };
}
