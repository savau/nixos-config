{ lib, pkgs, home, ... }:

{
  gtk = {
    enable = true;

    theme = {
      name = "Arc-Dark";
      package = pkgs.arc-theme;
    };
    iconTheme = {
      name = "Arc-Dark";
      package = pkgs.arc-icon-theme;
    };
    font = {
      name = "Sans 10";
    };

    gtk2.extraConfig = ''
      gtk-enable-event-sounds = 0
      gtk-enable-input-feedback-sounds = 0
    '';
    gtk3.extraConfig = {
      gtk-enable-event-sounds = 0;
      gtk-enable-input-feedback-sounds = 0;
    };
    gtk4.extraConfig = {
      gtk-enable-event-sounds = 0;
      gtk-enable-input-feedback-sounds = 0;
    };
  };
}
