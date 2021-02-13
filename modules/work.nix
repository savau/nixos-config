{ config, pkgs, ... }:

{
  imports = [
    ./work/direnv.nix
    ./work/u2w.nix
  ];
  
  environment.systemPackages = with pkgs; [
    # build-essentials
    binutils
    gcc
    gnumake
    pkgconfig
    python
    nodejs
    stack
    texlive.combined.scheme-full
    gup

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
    rstudio
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
