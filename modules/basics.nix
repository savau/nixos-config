{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    (import ./vim.nix)
    git
    htop
  ];

  services = {
    openssh.enable = true;  # allow to ssh in
  };
}
