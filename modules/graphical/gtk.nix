{ config, pkgs, ... }:

let
  myGtkExtraConfig = ''
    gtk-enable-event-sounds=0
    gtk-enable-input-feedback-sounds=0
  '';

  myGtkConfig = {
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

    gtk2.extraConfig = myGtkExtraConfig;
    gtk3.extraConfig = myGtkExtraConfig;
  };
in
{
  home-manager.users = {
    root.gtk = myGtkConfig;
    savau.gtk = myGtkConfig;
  };
}
