{ config, pkgs, ... }:

{
  services.xserver.displayManager.lightdm = {
    enable = true;
    greeters.gtk = {
      enable = true;
      theme = {
        name = "Arc-Dark";
      };
      iconTheme = {
        name = "Arc";
      };
      clock-format = "%Y-%m-%d %H:%M:%S";
      indicators = [ "~host" "~spacer" "~clock" "~separator" "~session" "~a11y" "~power" ];
      extraConfig = ''
        user-background = false
        hide-user-image = true
        reader = orca
      '';
  };
}
