{ config, pkgs, ... }:

{
  programs.ssh.startAgent = true;

  services.openssh.enable = true;

  environment.systemPackages = with pkgs; [
    sshfs
  ];
}
