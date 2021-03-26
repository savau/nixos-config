{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    zulip
  ];

  # Not adding zoom-us to systemPackages due to security concerns.
  # Install a sandboxed (bubblewrapped) Zoom via flatpak instead:
  #
  # $ flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
  # $ flatpak update
  # $ flatpak search zoom
  # $ flatpak install flathub us.zoom.Zoom
  #
  # (See also: https://blog.laxu.de/2020/04/02/how-use-zoom-sandbox/)
}
