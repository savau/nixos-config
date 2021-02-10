{ config, pkgs, ... }:

{
  imports = [ ./direnv.nix ];

  environment.systemPackages = with pkgs; [
    # build-essentials
    binutils
    gcc
    gnumake
    pkgconfig
    python
    ghc
    stack
    texlive.combined.scheme-full

    # prerequisites for Haskell Language Server
    ncurses
    icu.dev
    zlib
    
    # utilities
    wget
    unzip

    # nix
    nix-prefetch-git
    
    # desktop applications
    texstudio
    libreoffice
    zoom
    jetbrains.idea-community
  ];

  virtualisation = {
    libvirtd.enable = true;
    docker.enable = true;
  };

  boot.tmpOnTmpfs = true;

  services = {
    printing.enable = true;
  };

  programs = {
    ssh.startAgent = true;
    gnupg.agent.enable = true;
  };
}
