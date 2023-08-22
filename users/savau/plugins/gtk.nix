{ lib, pkgs, home, ... }:

{
  home.packages = with pkgs; [
    dconf
    gnome.adwaita-icon-theme
  ];

  dconf = {
    enable = true;
    settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
  };

  gtk = {
    enable = true;

    theme = {
      name = "Adwaita-dark";
    };
    iconTheme = {
      name = "Adwaita";
      package = pkgs.gnome.adwaita-icon-theme;
    };
    cursorTheme = {
      name = "Adwaita";
      package = pkgs.gnome.adwaita-icon-theme;
    };
    font = {
      name = "Liberation Sans Regular 10";
      package = pkgs.liberation_ttf;
    };

    gtk2.extraConfig = ''
      gtk-enable-event-sounds = 0
      gtk-enable-input-feedback-sounds = 0
      gtk-application-prefer-dark-theme=1
    '';
    gtk3.extraConfig = {
      gtk-enable-event-sounds = 0;
      gtk-enable-input-feedback-sounds = 0;
      gtk-application-prefer-dark-theme = 1;
    };
    gtk4.extraConfig = {
      gtk-enable-event-sounds = 0;
      gtk-enable-input-feedback-sounds = 0;
      gtk-application-prefer-dark-theme = 1;
    };
  };
}
