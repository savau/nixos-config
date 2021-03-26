args@{ config, pkgs, ... }:

{
  virtualisation = {
    docker.enable = true;
    libvirtd.enable = true;
  };

  environment.systemPackages = with pkgs; [
    virt-manager
  ];
}
