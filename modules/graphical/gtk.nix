{ config, pkgs, lib, machine, ... }:

with lib;

let
  myGtkConfig = {
    gtk = {
      enable = true;

      theme = {
        name = "Arc-Dark";
        package = pkgs.arc-theme;
      };
      iconTheme = {
        name = "Arc";
        package = pkgs.arc-icon-theme;
      };
      font = {
        name = "Sans 10";
      };

      # TODO: currently harcoded; how to share config definition with gtk2 and gtk3 extraConfig being of different types?
      gtk2.extraConfig = ''
        gtk-enable-event-sounds = 0
        gtk-enable-input-feedback-sounds = 0
      '';
      gtk3.extraConfig = {
        gtk-enable-event-sounds = 0;
        gtk-enable-input-feedback-sounds = 0;
      };
    };
  };
in
{
  gtk.iconCache.enable = true;
  home-manager.users = (mapAttrs (_: _: myGtkConfig) machine.users) // { root = myGtkConfig; };
}
