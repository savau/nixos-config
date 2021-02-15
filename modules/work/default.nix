{ config, pkgs, ... }:

{
  imports = [
    ./direnv.nix
    ./haskell.nix
    ./java.nix
    ./tex.nix
    ./u2w.nix
  ];

  boot.tmpOnTmpfs = true;
  
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
    nodejs-12_x
    pkgconfig
    python

    # utilities
    unzip
    wget

    # nix
    nix-prefetch-git
    
    # desktop applications
    libreoffice
    rstudio
    zoom
  ];
}
