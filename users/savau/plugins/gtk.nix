{ lib, pkgs, home, ... }:

{
  gtk = {
    enable = true;

    theme = {
      name = "Adwaita-Dark";
      package = pkgs.adwaita-theme;
    };
    iconTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };
    font = {
      name = "Liberation Sans Regular 10";
      package = pkgs.liberation-fonts;
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
