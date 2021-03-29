{ config, pkgs, ... }:

{
  programs.gnupg.agent.enable = true;

  # https://flatpak.org/setup/NixOS/
  # https://nixos.org/manual/nixos/stable/index.html#module-services-flatpak
  services.flatpak.enable = true;
  xdg.portal.enable = true;

  services.gnome3.gnome-keyring.enable = true;
  security.pam.services.lightdm.enableGnomeKeyring = true;
  programs.seahorse.enable = true;

  environment.systemPackages = with pkgs; [
    keepassxc
  ];
}
