args@{ config, pkgs, ... }:

{
  virtualisation = {
    docker.enable = true;
    libvirtd.enable = true;
  };

  programs.dconf.enable = true;

  environment.systemPackages = with pkgs; [
    virt-manager
  ];
}
