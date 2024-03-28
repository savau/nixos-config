{ config, pkgs, ... }:

{
  programs.ssh.startAgent = false; # use gnupg-agent with ssh-support instead

  services.openssh.enable = true;

  environment.systemPackages = with pkgs; [
    sshfs
  ];
}
