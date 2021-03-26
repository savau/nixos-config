{ config, pkgs, ... }:

{
  programs.ssh.startAgent = true;

  services.openssh.enable = true;  # allow to ssh in
}
