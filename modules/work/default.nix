args@{ config, pkgs, ... }:

{
  imports = [
    (import ./communication.nix args)
    (import ./direnv.nix args)
    (import ./haskell.nix args)
    (import ./java.nix args)
    (import ./tex.nix args)
    (import ./u2w.nix args)
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
