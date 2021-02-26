{ config, pkgs, lib, machine, ... }:

let
  moduleArgs = { inherit config; inherit pkgs; inherit lib; inherit machine; };
in
{
  imports = [
    (import ./communication.nix moduleArgs)
    (import ./direnv.nix moduleArgs)
    (import ./haskell.nix moduleArgs)
    (import ./java.nix moduleArgs)
    (import ./tex.nix moduleArgs)
    (import ./u2w.nix moduleArgs)
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
