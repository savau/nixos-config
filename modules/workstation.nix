{ config, pkgs, ... }:

{
  imports = [ ./direnv.nix ];

  environment.systemPackages = with pkgs; [
    # build-essentials
    binutils gcc gnumake pkgconfig python
    # utilities
    wget unzip
    # nix
    nix-prefetch-git
    # desktop
    firefox thunderbird
    evince okular
    zoom-us
    libreoffice
    texstudio
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
