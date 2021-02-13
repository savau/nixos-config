{ config, pkgs, ... }:

{
  imports = [
    ./work/direnv.nix
    ./work/u2w.nix
  ];

  boot.tmpOnTmpfs = true;
  
  programs = {
    gnupg.agent.enable = true;
    ssh.startAgent = true;
  };

  services = {
    printing.enable = true;
  };
  
  virtualisation = {
    docker.enable = true;
    libvirtd.enable = true;
  };

  environment.systemPackages = with pkgs; [
    # build-essentials
    binutils
    gcc
    gnumake
    gup
    nodejs
    pkgconfig
    python
    stack
    texlive.combined.scheme-full

    # prerequisites for Haskell Language Server
    icu.dev
    ncurses
    zlib
    
    # utilities
    unzip
    wget

    # nix
    nix-prefetch-git
    
    # desktop applications
    jetbrains.idea-community
    libreoffice
    rstudio
    texstudio
    zoom
  ];
}
