{ config, pkgs, ... }:

{
  imports = [
    ./communication.nix
    ./direnv.nix
    ./haskell.nix
    ./java.nix
    ./tex.nix
    ./u2w.nix
  ];

  programs = {
    gnupg.agent.enable = true;
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

    # utilities
    unzip
    wget

    # nix
    nix-prefetch-git
    
    # desktop applications
    libreoffice
    octave
    rstudio
  ];
}
