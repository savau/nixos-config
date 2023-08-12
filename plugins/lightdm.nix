{ config, pkgs, ... }:

{
  services.xserver.displayManager.lightdm = {
    enable = true;

    greeters.gtk = {
      enable = true;
      theme = {
        package = pkgs.arc-theme;
        name    = "Arc-Dark";
      };
      iconTheme = {
        package = pkgs.arc-theme;
        name    = "Arc";
      };
      clock-format = "%Y-%m-%d %H:%M:%S";
      indicators = [ "~host" "~spacer" "~clock" "~separator" "~session" "~a11y" "~power" ];
      extraConfig = ''
        background=#000000
        user-background=false
        hide-user-image=true
      '';
    };
  };
}
