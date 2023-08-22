{ lib, pkgs, home, ... }:

{
  home.packages = with pkgs; [
    gnome.adwaita-icon-theme
  ];

  programs.dconf.enable = true;

  gtk = {
    enable = true;

    theme.name = "Adwaita-Dark";
    iconTheme = {
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
