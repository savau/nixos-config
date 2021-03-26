{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    stack
    
    # Prerequisites for Haskell Language Server
    icu.dev
    ncurses
    zlib
  ];
}
