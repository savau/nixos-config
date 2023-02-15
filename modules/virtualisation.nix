args@{ config, pkgs, ... }:

{
  virtualisation = {
    docker.enable = false;
    libvirtd.enable = false;
  };

  programs.dconf.enable = true;

  # environment.systemPackages = with pkgs; [
  #   virt-manager
  # ];
}
