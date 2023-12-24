{ config, pkgs, ... }:

{
  programs.ssh.startAgent = false;

  services.openssh.enable = true;

  environment.systemPackages = with pkgs; [
    sshfs
  ];
}
